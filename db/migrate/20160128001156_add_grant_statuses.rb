class AddGrantStatuses < ActiveRecord::Migration
  def change
    create_table :grant_statuses do |t|
      t.string :description
    end

    add_column :grants, :grant_status_id, :integer

    add_foreign_key :grants, :grant_statuses
  end
end
