class AddUserIdToGrants < ActiveRecord::Migration
  def change
    add_column :grants, :user_id, :integer
  end
end
