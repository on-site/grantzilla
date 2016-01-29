class ExtractGrantIdFromPayees < ActiveRecord::Migration
  def up
    create_table :grants_payees do |t|
      t.references :grant, index: true, foreign_key: true
      t.references :payee, index: true, foreign_key: true
    end

    remove_column :payees, :grant_id, :integer
  end

  def down
    drop_table :grants_payees
    add_column :payees, :grant_id, :integer
    add_foreign_key :payees, :grants
  end
end
