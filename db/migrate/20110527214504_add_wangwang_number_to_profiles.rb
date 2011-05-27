class AddWangwangNumberToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :wangwang_number, :string
  end

  def self.down
    remove_column :profiles, :wangwang_number
  end
end
