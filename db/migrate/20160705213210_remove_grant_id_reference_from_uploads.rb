class RemoveGrantIdReferenceFromUploads < ActiveRecord::Migration
  def up
    remove_index :uploads, column: [:grant_id]
    remove_column :uploads, :grant_id
  end

  def down
    add_reference :uploads, :grant, index: true, foreign_key: true
  end
end
