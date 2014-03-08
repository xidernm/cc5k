class RemoveName9FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :name9, :string
  end
end
