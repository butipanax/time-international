class ShippingFee < ActiveRecord::Base
  validates_presence_of :weight, :price
end
