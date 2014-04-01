class AddTemporalToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :month, :integer
    add_column :answers, :year, :integer
  end
end
