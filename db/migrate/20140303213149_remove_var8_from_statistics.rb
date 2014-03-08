class RemoveVar8FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :var8, :string
  end
end
