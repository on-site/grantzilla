class AddDataImportHistoryLogs < ActiveRecord::Migration
  def change
    create_table :data_import_history_logs do |t|
      t.integer   :ehf_records_processed
      t.integer   :ehf_records_imported
      t.text      :errors, null: true
      t.timestamps
    end
  end
end
