class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstName, :string
    add_column :users, :lastName, :string
  end
end
