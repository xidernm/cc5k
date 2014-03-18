class AddStatisticIdToAnsweredFactors < ActiveRecord::Migration
  def change
    add_column :answered_factors, :statistic_id, :integer
  end
end
