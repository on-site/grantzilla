class FixGrantsMissingUsers < ActiveRecord::Migration
  def up
    return if Rails.env.production?

    agency = Agency.create

    user = User.new
    user.email = "foo@bar.baz"
    user.password = "password"
    user.agency = agency
    user.skip_confirmation!
    user.save

    Grant.where(user: nil).update_all(user_id: user)
    User.where(agency: nil).update_all(agency_id: agency)
  end

  def down
    # Not reversible.
  end
end
