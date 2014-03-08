class RemoveVar7FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :var7, :string
  end
end
