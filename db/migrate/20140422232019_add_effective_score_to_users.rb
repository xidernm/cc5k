class AddEffectiveScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :effective_score, :integer
  end
end
