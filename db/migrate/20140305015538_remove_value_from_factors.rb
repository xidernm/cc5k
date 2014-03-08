class RemoveValueFromFactors < ActiveRecord::Migration
  def change
    remove_column :factors, :value, :float
  end
end
