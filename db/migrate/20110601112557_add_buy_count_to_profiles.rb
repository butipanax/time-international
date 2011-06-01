class AddBuyCountToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :buy_count, :integer,:default=>0
  end

  def self.down
    remove_column :profiles, :buy_count
  end
end
