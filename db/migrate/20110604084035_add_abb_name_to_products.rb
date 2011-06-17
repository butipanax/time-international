class AddAbbNameToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :abb_name, :string
  end

  def self.down
    remove_column :products, :abb_name
  end
end
