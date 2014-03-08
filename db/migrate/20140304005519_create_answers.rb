class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.float :amount
      t.integer :user_id
      t.integer :statistic_id

      t.timestamps
    end
  end
end
