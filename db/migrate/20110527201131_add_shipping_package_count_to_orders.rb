class AddShippingPackageCountToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :package_count, :integer
  end

  def self.down
    remove_column :orders, :package_count
  end
end
