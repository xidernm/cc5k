class RemoveName1FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :name1, :string
  end
end
