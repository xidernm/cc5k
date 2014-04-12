class AddCategoryIdToStatistic < ActiveRecord::Migration
  def change
    add_column :statistics, :category_id, :integer
  end
end
