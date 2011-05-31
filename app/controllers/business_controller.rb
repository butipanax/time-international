class BusinessController < ApplicationController
  def index
  end

  def query_shipping_list

  end
  
  def shipping_list
    @inputted_date = params[:inputted_date]
    @orders = Order.shipping_list(DateTime.parse(@inputted_date),DateTime.parse(@inputted_date).tomorrow )

    @orders = @orders.paginate :page=>params[:page], :order => 'created_at desc', :per_page => 10
  end
end
