class AddShortNameToRegion < ActiveRecord::Migration
  def change
    add_column :regions, :short_name, :string
  end
end
