class RemoveName5FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :name5, :string
  end
end
