class RemoveAddressFromGrant < ActiveRecord::Migration
  def change
    remove_column :grants, :street_address, :string
    remove_column :grants, :unit_number, :string
    remove_column :grants, :city, :string
    remove_column :grants, :state, :string
    remove_column :grants, :zip, :string
    remove_column :grants, :move_in_date, :date
  end
end
