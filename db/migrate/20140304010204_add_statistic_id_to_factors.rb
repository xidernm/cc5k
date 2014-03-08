class AddStatisticIdToFactors < ActiveRecord::Migration
  def change
    add_column :factors, :statistic_id, :integer
  end
end
