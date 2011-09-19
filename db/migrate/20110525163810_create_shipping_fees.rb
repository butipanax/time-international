class CreateShippingFees < ActiveRecord::Migration
  def self.up
    create_table :shipping_fees do |t|
      t.decimal :weight
      t.decimal :price, :precision=>8,:scale=>2

      t.timestamps
    end
  end

  def self.down
    drop_table :shipping_fees
  end
end
