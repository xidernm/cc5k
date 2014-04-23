class AddWallpaperIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wallpaper_id, :integer
  end
end
