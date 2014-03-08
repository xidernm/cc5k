class RemoveName2FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :name2, :string
  end
end
