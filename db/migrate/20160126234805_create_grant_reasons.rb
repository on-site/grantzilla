class CreateGrantReasons < ActiveRecord::Migration
  def change
    create_table :grant_reasons do |t|
      t.integer :grant_id
      t.integer :reason_type_id
    end
    add_foreign_key :grant_reasons, :grants
    add_foreign_key :grant_reasons, :reason_types
  end
end
