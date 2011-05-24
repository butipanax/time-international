class ChangeDefaultValueToProfile < ActiveRecord::Migration
  def self.up
    change_column :profiles, :discount_rank, :integer, :default => 1
  end

  def self.down
    change_column :profiles, :discount_rank, :integer, :default => 0
  end
end
