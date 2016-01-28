class AddCellPhoneToPerson < ActiveRecord::Migration
  def change
    add_column :people, :cell, :string
  end
end
