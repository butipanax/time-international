class AddSexToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :sex, :boolean
  end

  def self.down
    remove_column :profiles, :sex
  end
end
