class AddStepToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :step, :string
  end
end
