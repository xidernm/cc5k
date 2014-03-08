class AddColumnsToFactors < ActiveRecord::Migration
  def change
    add_column :factors, :variableName, :string
    add_column :factors, :type, :integer
    add_column :factors, :unit, :string
  end
end
