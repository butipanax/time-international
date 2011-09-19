class AddProvinceAndMemoToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :province, :string
    add_column :orders, :memo, :text
  end

  def self.down
    remove_column :orders, :memo
    remove_column :orders, :province
  end
end
