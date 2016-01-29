require "rails_helper"

RSpec.describe Grant, type: :model do
  describe ".user_visible" do
    let!(:pending_status) { GrantStatus.where(pending: true).first }
    let!(:non_pending_status) { GrantStatus.where(pending: false).first }

    let!(:pending_grant) { Grant.create(status: pending_status) }
    let!(:non_pending_grant) { Grant.create(status: non_pending_status) }

    let!(:user_grants) { Grant.user_visible(user).map(&:id) }

    context "when given a case worker" do
      let(:user) { double("case_worker?" => true) }

      it "includes only pending grants" do
        expect(user_grants).to include(pending_grant.id)
        expect(user_grants).to_not include(non_pending_grant.id)
      end
    end

    context "when given an admin" do
      let(:user) { double("case_worker?" => false) }

      it "includes all grants" do
        expect(user_grants).to include(pending_grant.id)
        expect(user_grants).to include(non_pending_grant.id)
      end
    end
  end
end
