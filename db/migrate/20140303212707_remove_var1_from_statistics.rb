class RemoveVar1FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :var1, :string
  end
end
