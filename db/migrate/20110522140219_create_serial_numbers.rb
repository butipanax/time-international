class CreateSerialNumbers < ActiveRecord::Migration
  def self.up
    create_table :serial_numbers do |t|
      t.string :serial_number_name
      t.integer :current_max_number

      t.timestamps
    end
  end

  def self.down
    drop_table :serial_numbers
  end
end
