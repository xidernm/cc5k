class AddMinRankToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :min_rank, :integar
  end
end
