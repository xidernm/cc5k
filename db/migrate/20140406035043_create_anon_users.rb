class CreateAnonUsers < ActiveRecord::Migration
  def change
    create_table :anon_users do |t|
      t.string :ip
      t.string :visited_page

      t.timestamps
    end
  end
end
