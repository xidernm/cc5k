class AddNameToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :name, :string
  end
end
