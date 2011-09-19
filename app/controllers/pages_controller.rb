class PagesController < ApplicationController

  def home
     @cart = current_cart
  end

  def service
     @cart = current_cart
  end

  def contact
     @cart = current_cart
  end

end
