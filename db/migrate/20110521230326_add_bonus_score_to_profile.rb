class AddBonusScoreToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :bonus_score, :integer, :default => 0
  end

  def self.down
    remove_column :profiles, :bonus_score
  end
end
