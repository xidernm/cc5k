class AddDependencyToFactors < ActiveRecord::Migration
  def change
    add_column :factors, :dependency, :integer
  end
end
