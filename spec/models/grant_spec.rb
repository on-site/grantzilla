require "rails_helper"

RSpec.describe Grant, type: :model do
  describe "Grant.list" do
    let(:admin) { create(:user, :admin) }
    let(:worker1) { create(:user, :case_worker) }
    let(:worker2) { create(:user, :case_worker, agency: worker1.agency) }
    let(:worker3) { create(:user, :case_worker) }
    let(:grant1) { create(:grant, user: worker1) }
    let(:grant2) { create(:grant, user: worker2) }
    let(:grant3) { create(:grant, user: worker3) }
    before do
      grant1.people.create first_name: "Smelly", last_name: "Cat"
      grant2.people.create first_name: "Sammy", last_name: "Smith"
      grant3.people.create first_name: "Frank", last_name: "Furter"
    end
    context "when the user is an admin" do
      it "includes applications from all agencies" do
        grants = Grant.list(admin).all
        expect(grants).to include(grant1)
        expect(grants).to include(grant2)
        expect(grants).to include(grant3)
      end
      it "allows filtering by agency" do
        grants = Grant.list(admin, agency_id: grant1.user.agency_id).all
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
      it "allows searching" do
        grants = Grant.list(admin, search: "smel").all
        expect(grants).to include(grant1)
        expect(grants).to_not include(grant2)
        expect(grants).to_not include(grant3)
      end
    end
    context "when the user is a case worker" do
      context "when the user's account is approved" do
        let(:worker1) { create(:user, :case_worker, approved: true) }
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
        it "allows searching" do
          grants = Grant.list(worker1, search: "smel").all
          expect(grants).to include(grant1)
          expect(grants).to_not include(grant2)
          expect(grants).to_not include(grant3)
        end
      end
      context "when the user's account is not approved" do
        let(:worker1) { create(:user, :case_worker, approved: false) }
        it "includes only applications filed by them" do
          grants = Grant.list(worker1)
          expect(grants).to include(grant1)
          expect(grants).to_not include(grant2)
          expect(grants).to_not include(grant3)
        end
      end
      it "does not allow filtering by agency" do
        grants = Grant.list(worker1, agency_id: grant3.user.agency.id)
        expect(grants).to_not include(grant3)
      end
    end
  end
end
