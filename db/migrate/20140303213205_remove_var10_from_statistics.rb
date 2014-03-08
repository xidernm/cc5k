class RemoveVar10FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :var10, :string
  end
end
