class RemoveName8FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :name8, :string
  end
end
