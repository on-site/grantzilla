class InitializeExistingGrantStatuses < ActiveRecord::Migration
  def change
    Grant.update_all grant_status_id: 1
  end
end
