class RemoveName7FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :name7, :string
  end
end
