class RemoveName3FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :name3, :string
  end
end
