class AddGrantStatusData < ActiveRecord::Migration
  def change
    GrantStatus.create(description: "Incomplete")
    GrantStatus.create(description: "Submitted")
    GrantStatus.create(description: "Approved")
    GrantStatus.create(description: "Denied")
    GrantStatus.create(description: "Paid")
    GrantStatus.create(description: "Refund Needed")
    GrantStatus.create(description: "Refund Received")
  end
end
