class AddEquationToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :equation, :string
  end
end
