class ChangeGrantsDescriptionType < ActiveRecord::Migration
  def up
    change_column :grants, :details, :text
  end

  def down
    change_column :grants, :details, :string
  end
end
