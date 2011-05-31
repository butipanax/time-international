class ChangeOrderStatusColumnToOrders < ActiveRecord::Migration
  def self.up
    rename_column :orders, :order_status, :order_status_id
  end

  def self.down
    rename_column :orders, :order_status_id, :order_status
  end
end
