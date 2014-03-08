class RemoveVar2FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :var2, :string
  end
end
