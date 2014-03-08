class RemoveUserIdFromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :user_id, :integer
  end
end
