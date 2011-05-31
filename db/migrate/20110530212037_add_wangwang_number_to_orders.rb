class AddWangwangNumberToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :wangwang_number, :string
  end

  def self.down
    remove_column :orders, :wangwang_number
  end
end
