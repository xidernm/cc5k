class RemoveEquationFromStatistics < ActiveRecord::Migration
  def change
    remove_column :statistics, :equation, :string
  end
end
