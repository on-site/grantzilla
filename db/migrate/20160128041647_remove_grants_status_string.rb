class RemoveGrantsStatusString < ActiveRecord::Migration
  def change
    remove_column :grants, :status, :string
  end
end
