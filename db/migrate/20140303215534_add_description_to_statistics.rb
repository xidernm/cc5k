class AddDescriptionToStatistics < ActiveRecord::Migration
  def change
    add_column :statistics, :description, :string
  end
end
