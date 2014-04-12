class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.string :name
      t.text :description
      t.integer :value
      t.integer :user_id

      t.timestamps
    end
  end
end
