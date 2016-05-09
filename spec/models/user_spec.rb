require "rails_helper"

RSpec.describe User, type: :model do
  describe "#full_name" do
    let(:user) { User.new(first_name: "First", last_name: "Last") }

    it "correctly combines first and last name to provide full name" do
      expect(user.full_name).to eq("First Last")
    end
  end

  describe "#admin?" do
    let(:role) { "" }
    let(:user) { User.new(role: role) }

    context "not an admin user" do
      let(:role) { "case_worker" }

      it "returns false" do
        expect(user.admin?).to be false
      end
    end

    context "an admin user" do
      let(:role) { "admin" }

      it "returns true" do
        expect(user.admin?).to be true
      end
    end
  end

  describe "#case_worker?" do
    let(:role) { "" }
    let(:user) { User.new(role: role) }

    context "A case worker user" do
      let(:role) { "case_worker" }

      it "returns true" do
        expect(user.case_worker?).to be true
      end
    end

    context "an admin user" do
      let(:role) { "admin" }

      it "returns false" do
        expect(user.case_worker?).to be false
      end
    end
  end

  describe "User.list" do
    let(:agency1) { Agency.create }
    let(:agency2) { Agency.create }
    let(:worker1) { User.create first_name: "Fred", last_name: "Flintstone", email: "test1@test.com", password: "testtest", agency: agency1 }
    let(:worker2) { User.create first_name: "Betty", last_name: "Rubble", email: "test2@test.com", password: "testtest", agency: agency2 }
    before do
      worker1
      worker2
    end
    it "finds all users" do
      expect(User.list.size).to eq(2)
    end
    it "allows searching by name" do
      users = User.list(search: "flint")
      expect(users.size).to eq(1)
      expect(users).to include(worker1)
    end
    it "allows filtering by agency" do
      users = User.list(agency_id: agency1.id)
      expect(users.size).to eq(1)
      expect(users).to include(worker1)
    end
  end
end
