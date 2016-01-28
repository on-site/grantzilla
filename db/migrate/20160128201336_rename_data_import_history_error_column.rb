class RenameDataImportHistoryErrorColumn < ActiveRecord::Migration
  def change
    rename_column :data_import_history_logs, :errors, :error_encountered
  end
end
