require "rails_helper"

RSpec.describe Grant, type: :model do
  describe ".user_visible" do
    let(:pending_status) { GrantStatus.where(pending: true).first }
    let(:non_pending_status) { GrantStatus.where(pending: false).first }
    let(:user_grants) { Grant.user_visible(user).map(&:id) }

    before do
      @grant1 = Grant.create(status: pending_status)
      @grant2 = Grant.create(status: non_pending_status)
    end

    context "when given a case worker" do
      let(:user) { double("case_worker?" => true) }

      it "includes only pending grants" do
        expect(user_grants).to include(@grant1.id)
        expect(user_grants).to_not include(@grant2.id)
      end
    end

    context "when given an admin" do
      let(:user) { double("case_worker?" => false) }

      it "includes all grants" do
        expect(user_grants).to include(@grant1.id)
        expect(user_grants).to include(@grant2.id)
      end
    end
  end
end
