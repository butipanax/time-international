class MainController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_admin_activity
  def index
  end
  def statistic_turnover_form
    
  end
  def statistic_turnover_search

    sql_statement = "select distinct user_id, count(*) as count, sum(total_price) as total_goods_price, sum(package_count) as total_package_count, sum(shipping_price) as total_shipping_price,sum(pay_price) as turnover from orders where order_status_id=5"
    sql_statement2 = "select count(*) as count, sum(total_price) as total_goods_price, sum(package_count) as total_package_count, sum(shipping_price) as total_shipping_price,sum(pay_price) as turnover from orders where order_status_id=5"
    if (params[:accept_date] == '1')
      @s_b_date = params[:beginning_date]
      @s_e_date = params[:ending_date]
      where_date_statement = " and close_date between "+"'"+"#{DateTime.parse(params[:beginning_date]).to_date}"+"'"+" and "+"'" +"#{DateTime.parse(params[:ending_date]).tomorrow.to_date}"+"'"
      sql_statement << where_date_statement
      sql_statement2 << where_date_statement
    end
    if (params[:accept_name] == '1')
      @s_name = params[:name_search_field]
      user_id = 0
      if p = Profile.find_by_name(params[:name_search_field])
        user_id = p.user_id
      end
      where_name_satement = " and user_id = #{user_id}"
       sql_statement << where_name_satement
       sql_statement2 << where_name_satement       
    end

    sql_statement << " group by user_id"
  
    conn=ActiveRecord::Base.connection
    @statistic_result = conn.select_all( sql_statement)
    @statistic_result2 = conn.select_one(sql_statement2)
    
  end
  
  def statistic_goods_sales_form
    
  end
  def statistic_goods_sales_search
    sql_statement = "select distinct l.product_id, sum(l.quantity) as count, sum(l.price) as total_price from line_items l, orders o where l.order_id=o.id and o.order_status_id=5"
    if (params[:accept_date] == '1')
      @s_b_date = params[:beginning_date]
      @s_e_date = params[:ending_date]
      where_date_statement = " and o.close_date between "+"'"+"#{DateTime.parse(params[:beginning_date]).to_date}"+"'"+" and "+"'" +"#{DateTime.parse(params[:ending_date]).tomorrow.to_date}"+"'"
      sql_statement << where_date_statement
    end  
    sql_statement << " group by l.product_id"
    conn=ActiveRecord::Base.connection
    @statistic_result = conn.select_all( sql_statement) 
 end
  
  def statistic_balance_form
    
  end
  def statistic_balance_search
    sql_statement = "select sum(p.cost) as total_cost,sum(o.shipping_price) as total_shipping_price,sum(o.pay_price) as turnover from line_items l, orders o, products p where l.order_id=o.id and o.order_status_id=5 and p.id=l.product_id"  
    if (params[:accept_date] == '1')
      @s_b_date = params[:beginning_date]
      @s_e_date = params[:ending_date]
      where_date_statement = " and o.close_date between "+"'"+"#{DateTime.parse(params[:beginning_date]).to_date}"+"'"+" and "+"'" +"#{DateTime.parse(params[:ending_date]).tomorrow.to_date}"+"'"  
      sql_statement << where_date_statement
    end
    conn=ActiveRecord::Base.connection
    @statistic_result = conn.select_one( sql_statement)   
  end
end
