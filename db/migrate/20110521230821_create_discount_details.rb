class CreateDiscountDetails < ActiveRecord::Migration
  def self.up
    create_table :discount_details do |t|
      t.decimal :discount_rate, :precision => 4, :scale =>2 ,:default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :discount_details
  end
end
