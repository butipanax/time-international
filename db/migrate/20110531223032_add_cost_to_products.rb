class AddCostToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :cost, :decimal, :precision => 10, :scale => 2
  end

  def self.down
    remove_column :products, :cost
  end
end
