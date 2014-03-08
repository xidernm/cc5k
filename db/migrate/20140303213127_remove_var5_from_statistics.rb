class RemoveVar5FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :var5, :string
  end
end
