class RemoveGrantReasons < ActiveRecord::Migration
  def up
    drop_table :grant_reasons
  end

  def down
    create_table :grant_reasons do |t|
      t.integer :grant_id
      t.integer :reason_type_id
    end
  end
end
