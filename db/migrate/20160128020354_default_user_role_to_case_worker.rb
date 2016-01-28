class DefaultUserRoleToCaseWorker < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, default: "case_worker"
  end
end
