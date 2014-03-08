class RemoveName6FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :name6, :string
  end
end
