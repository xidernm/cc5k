class AddUserIdToAnsweredFactors < ActiveRecord::Migration
  def change
    add_column :answered_factors, :user_id, :integer
  end
end
