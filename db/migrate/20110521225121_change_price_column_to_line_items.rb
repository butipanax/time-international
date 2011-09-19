class ChangePriceColumnToLineItems < ActiveRecord::Migration
  def self.up
    change_column :line_items, :price, :decimal, :precision => 10, :scale => 2
  end

  def self.down
    change_column :line_items, :price, :decimal
  end
end
