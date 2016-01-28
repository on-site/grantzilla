class GrantStatus < ActiveRecord::Base; end

class AddGrantStatusData < ActiveRecord::Migration
  def up
    GrantStatus.delete_all
    GrantStatus.create(description: "Incomplete", id: 1)
    GrantStatus.create(description: "Submitted")
    GrantStatus.create(description: "Approved")
    GrantStatus.create(description: "Denied")
    GrantStatus.create(description: "Paid")
    GrantStatus.create(description: "Refund Needed")
    GrantStatus.create(description: "Refund Received")
  end

  def down
    GrantStatus.delete_all
  end
end
