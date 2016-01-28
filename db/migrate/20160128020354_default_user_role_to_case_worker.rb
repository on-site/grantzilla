class DefaultUserRoleToCaseWorker < ActiveRecord::Migration
  def up
    change_column :users, :role, :string, default: "case_worker"
  end

  def down
    change_column :users, :role, :string, default: "user"
  end
end
