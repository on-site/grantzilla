class AddStepToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :step, :string, default: Grant::STEPS.first
  end
end
