class AddCategoryIdToFactors < ActiveRecord::Migration
  def change
    add_column :factors, :category_id, :integer
  end
end
