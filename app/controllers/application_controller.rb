class ApplicationController < ActionController::Base
  protect_from_forgery

#  rescue_from CanCan:AccessDenied do |exception|
#    flash[:error] = exception.message
#    redirect_to root_url
#  end




def current_cart 
  begin
  Cart.find(session[:cart_id]) 
  rescue ActiveRecord::RecordNotFound 
    cart = Cart.create 
    session[:cart_id] = cart.id 
    cart
  end
end

private :current_cart

end
