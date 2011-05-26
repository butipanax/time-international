class AddWeightPriceColumnsToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :shipping_price, :decimal,:precision=>10, :scale=>2
    add_column :orders, :pay_price, :decimal,:precision=>10,:scale=>2
  end

  def self.down
    remove_column :orders, :pay_price
    remove_column :orders, :shipping_price
  end
end
