class ChangePriceColumnToOrder < ActiveRecord::Migration
  def self.up
    change_column :orders, :total_price, :decimal, :precision => 10, :scale => 2
    change_column :orders, :discount_price, :decimal, :precision => 10, :scale => 2
  end

  def self.down
    change_column :orders, :total_price, :decimal
    change_column :orders, :discount_price, :decimal
  end
end
