class RemoveVar9FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :var9, :string
  end
end
