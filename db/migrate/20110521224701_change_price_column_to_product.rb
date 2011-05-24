class ChangePriceColumnToProduct < ActiveRecord::Migration
  def self.up
    change_column :products, :price, :decimal, :precision => 10, :scale => 2
  end

  def self.down
    change_column :products, :price, :decimal
  end
end
