class AddForeignKeysToEarnedBadges < ActiveRecord::Migration
  def change
    add_column :earned_badges, :user_id, :integer
    add_column :earned_badges, :badge_id, :integer
  end
end
