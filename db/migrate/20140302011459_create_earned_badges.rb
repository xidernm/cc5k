class CreateEarnedBadges < ActiveRecord::Migration
  def change
    create_table :earned_badges do |t|

      t.timestamps
    end
  end
end
