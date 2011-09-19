class CreateBonusUpgradeDetails < ActiveRecord::Migration
  def self.up
    create_table :bonus_upgrade_details do |t|
      t.string :objective_name
      t.integer :bonus_reward_score
      t.decimal :bonus_reward_price
      t.integer :upgrade_count
      t.integer :upgrade_level

      t.timestamps
    end
  end

  def self.down
    drop_table :bonus_upgrade_details
  end
end
