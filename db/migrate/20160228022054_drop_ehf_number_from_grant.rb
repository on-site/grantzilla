class DropEhfNumberFromGrant < ActiveRecord::Migration
  def change
    remove_column :grants, :ehf_number, :string
  end
end
