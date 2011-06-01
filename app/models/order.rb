class Order < ActiveRecord::Base
  validates :name, :address, :postcode, :telephone, :presence => true
  belongs_to :order_status, :foreign_key => :order_status_id
  has_many :line_items
  scope :shipping_list , lambda {|date_begin, date_end|where('payment_date > ? and payment_date < ?',date_begin,date_end)}
  scope :close_list , lambda {|date_begin, date_end|where('close_date > ? and close_date < ?',date_begin,date_end)}
end
