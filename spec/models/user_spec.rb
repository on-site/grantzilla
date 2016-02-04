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
end
