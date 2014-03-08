class AddUsageToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :usage_type_id, :integer
  end
end
