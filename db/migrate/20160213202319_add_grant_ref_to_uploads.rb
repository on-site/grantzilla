class AddGrantRefToUploads < ActiveRecord::Migration
  def change
    add_reference :uploads, :grant, index: true, foreign_key: true
  end
end
