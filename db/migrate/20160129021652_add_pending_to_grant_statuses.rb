class AddPendingToGrantStatuses < ActiveRecord::Migration
  def up
    add_column :grant_statuses, :pending, :boolean, null: false, default: false

    GrantStatus.where(description: %w{Incomplete Submitted})
      .update_all(pending: true)
  end

  def down
    remove_column :grant_statuses, :pending
  end
end
