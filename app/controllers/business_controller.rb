#encoding: utf-8

require 'csv'

class BusinessController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_staff_activity
  def index
  end

  def query_shipping_list

  end

  def shipping_list
    @inputted_date = params[:inputted_date]
    @orders = Order.shipping_list(DateTime.parse(@inputted_date),DateTime.parse(@inputted_date).tomorrow ) 
    CSV::open('shipping_list.csv', 'wb') do |title|
      #title << ['name','address','postcode','telephone','invoice_number','goods']
      title << ['姓名','地址','邮编','联系电话', '订单号','订购商品']
      @orders.each do |o|
        goods =""
        o.line_items.each do |l|
          goods << l.product.title
          goods << " "
          goods << l.quantity
          goods << "份   " 
        end
        title << [o.name, o.address, o.postcode, o.telephone, o.invoice_number,goods]
      end
    end
    @orders = @orders.paginate :page=>params[:page], :order => 'created_at desc', :per_page => 10
  end

  def export_to_csv   
    send_file('shipping_list.csv',:type => 'text/csv; charset=utf-8; header=present',:filename => "shipping_list.csv", :disposition =>'attachment', :encoding => 'utf-8')
  end
  
  def order_search_form

  end
  
  def get_orders_searching_result
    if params[:name] == 'name'
      @orders = Order.where("name like ?", "%#{params[:name_search_field]}%")
    end
    if params[:name] == 'wangwang'
      @orders = Order.where("wangwang_number like ?", "%#{params[:wangwang_search_field]}")  
    end
    if params[:name] == 'email'      
      aUser = User.find_by_email(params[:email_search_field])
      aId =""
      aId = aUser.id if aUser
      @orders = Order.where("user_id = ?", "#{aId}")
    end
    if params[:name] == 'date'
     @orders = Order.close_list(DateTime.parse(params[:beginning_date]),DateTime.parse(params[:ending_date]).tomorrow ) 
    end
    if @orders
     @orders = @orders.paginate :page=>params[:page], :order => 'name desc', :per_page => 12
    end
    render "orders_search_result_list"
  end
end
