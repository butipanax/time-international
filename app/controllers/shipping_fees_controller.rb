class ShippingFeesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin_activity
  # GET /shipping_fees
  # GET /shipping_fees.xml
  def index
    @shipping_fees = ShippingFee.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shipping_fees }
    end
  end

  # GET /shipping_fees/1
  # GET /shipping_fees/1.xml
  def show
    @shipping_fee = ShippingFee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shipping_fee }
    end
  end

  # GET /shipping_fees/new
  # GET /shipping_fees/new.xml
  def new
    @shipping_fee = ShippingFee.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shipping_fee }
    end
  end

  # GET /shipping_fees/1/edit
  def edit
    @shipping_fee = ShippingFee.find(params[:id])
  end

  # POST /shipping_fees
  # POST /shipping_fees.xml
  def create
    @shipping_fee = ShippingFee.new(params[:shipping_fee])

    respond_to do |format|
      if @shipping_fee.save
        format.html { redirect_to(@shipping_fee, :notice => 'Shipping fee was successfully created.') }
        format.xml  { render :xml => @shipping_fee, :status => :created, :location => @shipping_fee }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shipping_fee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shipping_fees/1
  # PUT /shipping_fees/1.xml
  def update
    @shipping_fee = ShippingFee.find(params[:id])

    respond_to do |format|
      if @shipping_fee.update_attributes(params[:shipping_fee])
        format.html { redirect_to(@shipping_fee, :notice => 'Shipping fee was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shipping_fee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shipping_fees/1
  # DELETE /shipping_fees/1.xml
  def destroy
    @shipping_fee = ShippingFee.find(params[:id])
    @shipping_fee.destroy

    respond_to do |format|
      format.html { redirect_to(shipping_fees_url) }
      format.xml  { head :ok }
    end
  end
end
