#encoding: utf-8
require 'digest/md5'
require 'net/http'
require 'open-uri'
require 'iconv'
require 'cgi'
require 'rexml/document'

class OrdersController < ApplicationController
  before_filter :authenticate_user!
  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.where("order_status_id != 5 and order_status_id != 4")
    @orders = @orders.paginate :page=>params[:page], :order => 'name desc', :per_page => 22
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
  
  def order_confirmation
    @order = Order.find(params[:id])
    render 'orders/order_confirmation'
  
  end
  
  # GET /orders/new
  # GET /orders/new.xml
  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to products_url, :notice => "您尚未购买任何产品！"
      return
    end

    @order = Order.new(:pay_type => 'pay_pal')
    @order.email = current_user.email
  

    @discount_rate =  1
    profile = current_user.profile  
    if profile
      @discount_rate = profile.discount_detail.discount_rate
      @order.name = profile.name    
      @order.province = profile.province
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
    if @cart.line_items.empty?
      redirect_to products_url, :notice => "注意，上一次操作后，您的购物车已经被清空！" and return
    end
    
    profile = current_user.profile
    @discount_rate = 1
    
    profile = current_user.profile || current_user.create_profile
    @discount_rate = profile.discount_detail.discount_rate
    
    @order.user_id = current_user.id
    @order.total_price = @cart.total_price
    @order.discount_price = @discount_rate * @cart.total_price
    
    total_weight=0
    @cart.line_items.each do |line_item|
      total_weight += line_item.product.weight*line_item.quantity
    end
    
    @order.package_count = (total_weight / 5).to_i + 1
    @order.shipping_price = ((total_weight / 5).to_i + 1)*ShippingFee.find_by_weight(5).price
    @order.pay_price = @order.shipping_price + @order.discount_price

    tmp_number_string = 0
    SerialNumber.transaction do
      current_invoice_serial = SerialNumber.find_by_serial_number_name("used_by_invoice_number",:lock => true)
      current_invoice_number = current_invoice_serial.current_max_number
      tmp_number_string = (100000000 + current_invoice_number).to_s
      current_invoice_serial.current_max_number = current_invoice_number + 1
      current_invoice_serial.save!
    end

    @order.invoice_number =  "TIG"<<tmp_number_string[1,tmp_number_string.length]
    @order.order_status_id = OrderStatus.find_by_id(1)
    title="婴儿营养品" << tmp_number_string[1,tmp_number_string.length]
   
    if @order.pay_type == 'pay_taobao'
      xml_data = Net::HTTP.get_response(getRequestUrl(title,@order.pay_price)).body
      doc = REXML::Document.new(xml_data)
      taobao_id = doc.elements['item_add_response/item/iid'].text
      xml_data2 = Net::HTTP.get_response(getRequestUrl2(taobao_id)).body
      doc2 =REXML::Document.new(xml_data2)
      taobao_url = doc2.elements['item_get_response/item/detail_url'].text

      @order.taobao_invoice_number = taobao_id
      @order.taobao_url=taobao_url
    end
    
    respond_to do |format|
      if @order.save 
        profile.save
        @cart.line_items.each do |line_item|
          line_item.update_attribute(:order_id, @order.id)
        end
        Notifier.order_created(@order).deliver
        @cart = nil
        session[:cart_id] = nil
        format.html { render 'orders/order_confirmation', :notice => '订单成功生成，您将收到一封我们的确认信件！ ' }
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
    profile = Profile.find_by_user_id(@order.user_id)
    
    if params[:order][:order_status_id] == '2'
      @order.payment_date = Time.now
    elsif params[:order][:order_status_id]  == '3'
      @order.shipping_date = Time.now
    elsif params[:order][:order_status_id]  == '5'
      @order.close_date = Time.now
      profile.buy_count = profile.buy_count + 1
      upgrade_class = BonusUpgradeDetail.find_by_upgrade_level(profile.discount_rank + 1)
      upgrade_count = upgrade_class ? upgrade_class.upgrade_count : 99999
      if profile.buy_count == upgrade_count
        profile.discount_rank = profile.discount_rank + 1
      end 
      bonus_class= BonusUpgradeDetail.find_by_objective_name("bonus")
      if bonus_class.bonus_reward_price != 0
        profile.bonus_score =  profile.bonus_score + (@order.pay_price / bonus_class.bonus_reward_price).to_i * bonus_class.bonus_reward_score
      end
    end
    respond_to do |format|
      if (@order.save && @order.update_attributes(params[:order]) && profile.save)
        if @order.order_status_id == 3
          Notifier.order_shipped(@order).deliver
        end
        format.html { redirect_to(@order, :notice => '更新成功！') }
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
  
  
 def getArgumentPara(title,price)
 
    price_string = price.to_s

    paramArray = {
      'app_key'=>'12219070',
      'method'=>'taobao.item.add',
      'format'=>'xml',
      'v'=>'2.0',
      'timestamp'=>Time.new().strftime("%Y-%m-%d %H:%M:%S"),
      'num'=>1.to_s,
      'price'=>price_string,
      'type'=>'fixed',
      'stuff_status'=>'new',
      'title'=>title,
      'desc'=>'婴儿营养或辅助类产品',
      'location.state'=>'上海',
      'location.city'=>'上海',
      'cid'=>'50018837'
    }
  end

  def getArgumentPara2(taobao_id)

    paramArray = {
      'app_key'=>'12219070',
      'method'=>'taobao.item.get',
      'format'=>'xml',
      'v'=>'2.0',
      'timestamp'=>Time.new().strftime("%Y-%m-%d %H:%M:%S"),
      'fields'=>'detail_url',
      'num_iid'=>taobao_id
    }
  end

  def sign(param,sercetCode)
    Digest::MD5.hexdigest('sandbox36f17baa86659f353f9f8a88a' + param.sort.flatten.join).upcase
  end

  #组装请求参数

  def createRequestParam(paramArray)
    array = paramArray.sort()
    i = 0
    str = ''
    while i < paramArray.length()
      temp = array[i]
      str = str + temp[0] + '=' + CGI.escape(temp[1]) + '&'
      i = i + 1
    end
    return str
  end

  def getRequestUrl(title,price)
    #url = 'http://gw.api.taobao.com/router/rest?'
    url = 'http://gw.api.tbsandbox.com/router/rest?'
    url = url + createRequestParam(getArgumentPara(title,price))+'sign=' + sign(getArgumentPara(title,price),'sandbox36f17baa86659f353f9f8a88a')
    parsedURL = URI.parse(url)
  end

  def getRequestUrl2(taobao_id)
    url = 'http://gw.api.tbsandbox.com/router/rest?'
    url = url + createRequestParam(getArgumentPara2(taobao_id))+'sign=' + sign(getArgumentPara2(taobao_id),'sandbox36f17baa86659f353f9f8a88a')
    parsedURL = URI.parse(url)
  end


end
