class GrantStatus < ActiveRecord::Base; end

class AddGrantStatusData < ActiveRecord::Migration
  def up
    remove_foreign_key "grants", "grant_statuses"
    execute 'TRUNCATE TABLE grant_statuses'
    execute 'ALTER SEQUENCE grants_id_seq RESTART WITH 1;'
    GrantStatus.create(description: "Incomplete")
    GrantStatus.create(description: "Submitted")
    GrantStatus.create(description: "Approved")
    GrantStatus.create(description: "Denied")
    GrantStatus.create(description: "Paid")
    GrantStatus.create(description: "Refund Needed")
    GrantStatus.create(description: "Refund Received")
    add_foreign_key "grants", "grant_statuses"
  end

  def down
    GrantStatus.delete_all
  end
end
