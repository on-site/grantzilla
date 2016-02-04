class AddApprovedToUser < ActiveRecord::Migration
  def change
    remove_column :users, :validated, :boolean
    add_column :users, :approved, :boolean, default: false, null: true
    add_index :users, :approved
  end
end
