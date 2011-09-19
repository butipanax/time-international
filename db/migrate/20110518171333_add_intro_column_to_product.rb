class AddIntroColumnToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :intro, :text
  end

  def self.down
    remove_column :products, :intro
  end
end
