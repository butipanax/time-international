class Cart < ActiveRecord::Base
  has_many :line_items
  
  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    product_price = Product.find_by_id(product_id).price
    if current_item
      current_item.quantity += 1
      current_item.price += product_price
    else
      current_item = line_items.build(:product_id => product_id,:price => product_price)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum{|item| item.price }
  end
  
  def total_items
    line_items.sum(:quantity)
  end
end
