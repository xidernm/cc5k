class AddTemporalToAnsweredFactors < ActiveRecord::Migration
  def change
    add_column :answered_factors, :month, :integer
    add_column :answered_factors, :year, :integer
  end
end
