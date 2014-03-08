class RemoveName10FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :name10, :string
  end
end
