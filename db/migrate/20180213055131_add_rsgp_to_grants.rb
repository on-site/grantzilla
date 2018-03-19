class AddRsgpToGrants < ActiveRecord::Migration[5.0]
  def change
    add_column :grants, :grant_rsgp, :string
  end
end
