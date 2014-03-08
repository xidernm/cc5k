class RemoveVar6FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :var6, :string
  end
end
