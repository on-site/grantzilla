class ImportedEhfRecords < ActiveRecord::Migration[5.0]
  def change
    enable_extension "hstore"
    create_table :imported_ehf_records do |t|
      t.integer :grant_id
      t.hstore  :ehf_record
    end

    add_index :imported_ehf_records, :grant_id
  end
end
