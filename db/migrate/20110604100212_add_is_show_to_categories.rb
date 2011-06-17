class AddIsShowToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :is_show, :integer, :default => 1
  end

  def self.down
    remove_column :categories, :is_show
  end
end
