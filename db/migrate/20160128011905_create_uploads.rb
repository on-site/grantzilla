class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.references :user, index: true, polymorphic: true, null: false
      t.string :description
      t.string :category
      t.string :file_fingerprint, null: false
      t.attachment :file, null: false

      t.timestamps null: false
    end
  end
end
