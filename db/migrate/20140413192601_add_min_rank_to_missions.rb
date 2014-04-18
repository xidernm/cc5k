class AddMinRankToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :min_rank, :integer
  end
end
