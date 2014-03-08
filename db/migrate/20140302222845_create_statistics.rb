class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.string :var1
      t.string :name1
      t.string :var2
      t.string :name2
      t.string :var3
      t.string :name3
      t.string :var4
      t.string :name4
      t.string :var5
      t.string :name5
      t.string :var6
      t.string :name6
      t.string :var7
      t.string :name7
      t.string :var8
      t.string :name8
      t.string :var9
      t.string :name9
      t.string :var10
      t.string :name10
      t.string :equation
      
      t.timestamps
    end
  end
end
