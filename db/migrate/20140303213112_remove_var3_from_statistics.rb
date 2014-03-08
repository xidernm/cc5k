class RemoveVar3FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :var3, :string
  end
end
