class AddProvinceToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :province, :string
  end

  def self.down
    remove_column :profiles, :province
  end
end
