class AddTimesCompletedToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :times_completed, :integer
  end
end
