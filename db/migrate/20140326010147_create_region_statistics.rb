class CreateRegionStatistics < ActiveRecord::Migration
  def change
    create_table :region_statistics do |t|
      t.integer :region_id
      t.float :amount
      t.string :stat_type

      t.timestamps
    end
  end
end
