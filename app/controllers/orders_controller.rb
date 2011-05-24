#encoding: utf-8

class OrdersController < ApplicationController
  before_filter :authenticate_user!
  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to :controller => 'Products', :action => 'show_products_by_category', :notice => "您尚未购买任何产品！"
    return
    end

    @order = Order.new
    @order.email = current_user.email
  

    @discount_rate =  1
    profile = current_user.profile  
    if profile
      @discount_rate = profile.discount_detail.discount_rate
      @order.name = profile.name    
      @order.address = profile.address
      @order.postcode = profile.postcode
      @order.telephone = profile.telephone
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])
    @cart = current_cart
    profile = current_user.profile
    @discount_rate = 1
    
    profile = current_user.profile
    @discount_rate = profile.discount_detail.discount_rate if profile
        
    
    @order.user_id = current_user.id
    @order.total_price = @cart.total_price
    @order.discount_price = @discount_rate * @cart.total_price

    tmp_number_string = 0
    SerialNumber.transaction do
      current_invoice_serial = SerialNumber.find_by_serial_number_name("used_by_invoice_number",:lock => true)
      current_invoice_number = current_invoice_serial.current_max_number
      tmp_number_string = (100000000 + current_invoice_number).to_s
      current_invoice_serial.current_max_number = current_invoice_number + 1
      current_invoice_serial.save!
    end

    @order.invoice_number =  "TIG"<<tmp_number_string[1,tmp_number_string.length]
    @order.order_status = 1
    

    respond_to do |format|
      if @order.save 
        @cart.line_items.each do |line_item|
          line_item.update_attribute(:order_id, @order.id)
        end
        format.html { redirect_to(@order, :notice => 'Order was successfully created.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
  
  def order_search_form
    render 'orders/order_search_form'
  end
end
