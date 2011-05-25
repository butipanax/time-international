class AddWeightToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :weight, :decimal,:precision => 6, :scale => 2, :default => 0 
  end

  def self.down
    remove_column :products, :weight
  end
end
