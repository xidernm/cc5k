class AddAmountToFactors < ActiveRecord::Migration
  def change
    add_column :factors, :amount, :float
  end
end
