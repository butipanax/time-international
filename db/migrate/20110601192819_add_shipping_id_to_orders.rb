class AddShippingIdToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :shipping_number, :string
  end

  def self.down
    remove_column :orders, :shipping_number
  end
end
