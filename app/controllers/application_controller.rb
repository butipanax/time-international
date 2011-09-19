#encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

#  rescue_from CanCan:AccessDenied do |exception|
#    flash[:error] = exception.message
#    redirect_to root_url
#  end

def  authenticate_staff_activity
 if not (current_user.role?("staff") ||  current_user.role?("admin"))
    flash[:notice] = "对不起，您没有权限访问该网址！"
    redirect_to root_url
 end
end

def  authenticate_admin_activity
 if not current_user.role?("admin") 
    flash[:notice] = "对不起，您没有权限访问该网址！"
    redirect_to root_url
 end
end

def current_cart 
  begin
  Cart.find(session[:cart_id]) 
  rescue ActiveRecord::RecordNotFound 
    cart = Cart.create 
    session[:cart_id] = cart.id 
    cart
  end
end

private :current_cart,:authenticate_staff_activity,:authenticate_admin_activity

end
