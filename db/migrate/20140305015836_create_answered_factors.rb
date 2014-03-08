class CreateAnsweredFactors < ActiveRecord::Migration
  def change
    create_table :answered_factors do |t|
      t.integer :factor_id
      t.integer :answer_id
      t.float :amount

      t.timestamps
    end
  end
end
