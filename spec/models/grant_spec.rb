require "rails_helper"

RSpec.describe Grant, type: :model do
  describe "Grant.list" do
    let(:status) { GrantStatus.create id: 1, description: "Incomplete" }
    let(:agency1) { Agency.create }
    let(:agency2) { Agency.create }
    let(:admin) { User.create role: "admin" }
    let(:worker1) { User.create email: "test1@test.com", password: "testtest", agency: agency1 }
    let(:worker2) { User.create email: "test2@test.com", password: "testtest", agency: agency1 }
    let(:worker3) { User.create email: "test3@test.com", password: "testtest", agency: agency2 }
    let(:grant1) { Grant.create total_rent: 1000.0, status: status, user_id: worker1.id }
    let(:grant2) { Grant.create total_rent: 1000.0, status: status, user_id: worker2.id }
    let(:grant3) { Grant.create total_rent: 1000.0, status: status, user_id: worker3.id }
    before do
      grant1
      grant2
      grant3
    end
    context "when the user is an admin" do
      it "includes applications from all agencies" do
        grants = Grant.list(admin).all
        expect(grants).to include(grant1)
        expect(grants).to include(grant2)
        expect(grants).to include(grant3)
      end
      it "allows filtering by agency" do
        grants = Grant.list(admin, agency_id: agency1.id).all
        expect(grants).to include(grant1)
        expect(grants).to include(grant2)
        expect(grants).to_not include(grant3)
      end
      it "allows filtering by case worker" do
        grants = Grant.list(admin, user_id: worker1.id).all
        expect(grants).to include(grant1)
        expect(grants).to_not include(grant2)
        expect(grants).to_not include(grant3)
      end
    end
    context "when the user is a case worker" do
      context "when the user's account is approved" do
        let(:worker1) { User.create email: "test1@test.com", password: "testtest", agency: agency1, approved: true }
        it "includes only applications from their agency" do
          grants = Grant.list(worker1)
          expect(grants).to include(grant1)
          expect(grants).to include(grant2)
          expect(grants).to_not include(grant3)
        end
        it "allows filtering by case worker" do
          grants = Grant.list(worker1, user_id: worker2.id)
          expect(grants).to_not include(grant1)
          expect(grants).to include(grant2)
          expect(grants).to_not include(grant3)
        end
      end
      context "when the user's account is not approved" do
        it "includes only applications filed by them" do
          grants = Grant.list(worker1)
          expect(grants).to include(grant1)
          expect(grants).to_not include(grant2)
          expect(grants).to_not include(grant3)
        end
      end
      it "does not allow filtering by agency" do
        grants = Grant.list(worker1, agency_id: agency2.id)
        expect(grants).to_not include(grant3)
      end
    end
  end
end
