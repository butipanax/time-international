class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.string :name
      t.string :address
      t.string :email
      t.string :postcode
      t.string :telephone
      t.string :pay_type
      t.string :taobao_url
      t.string :taobao_invoice_number
      t.decimal :total_price
      t.decimal :discount_price
      t.string :invoice_number
      t.integer :order_status
      t.datetime :shipping_date
      t.datetime :payment_date
      t.datetime :close_date
      t.text :cancel_reason

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
