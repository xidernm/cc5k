class AddUserIdToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :user_id, :integer
  end
end
