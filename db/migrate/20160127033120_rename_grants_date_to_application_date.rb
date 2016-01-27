class RenameGrantsDateToApplicationDate < ActiveRecord::Migration
  def change
    rename_column :grants, :date, :application_date
  end
end
