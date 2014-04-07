class AddVisitedPageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visited_page, :string
  end
end
