class AddCategoryIdToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :category_id, :integer
  end
end
