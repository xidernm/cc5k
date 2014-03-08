class RemoveName4FromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :name4, :string
  end
end
