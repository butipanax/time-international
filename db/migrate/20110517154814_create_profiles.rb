class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :name
      t.string :address
      t.string :postcode
      t.string :telephone
      t.integer :discount_rank,:default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
