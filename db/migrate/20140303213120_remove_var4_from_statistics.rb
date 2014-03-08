class RemoveVar4FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :var4, :string
  end
end
