class Order < ActiveRecord::Base
  validates :name, :address, :postcode, :telephone, :presence => true
  belongs_to :order_status, :foreign_key => :order_status
end
