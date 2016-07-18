# frozen_string_literal: true
require "rails_helper"

RSpec.describe Agency, type: :model do
  describe "#full_address" do
    let(:agency) { create(:agency, address: "123 Main Street", city: "San Jose", state: "CA", zip: "95123") }
    context "agency record includes all address fields" do
      it "provides a properly formated full address" do
        expect(agency.full_address).to eq("123 Main Street, San Jose, CA 95123")
      end
    end
  end

  describe ".ordered_agencies" do
    before do
      create(:agency, name: "Zillow Agency")
      create(:agency, name: "Acme Agency")
    end

    it "lists all agecies in alphabetical order" do
      expect(Agency.ordered_agencies.map(&:name)).to eq(["Acme Agency", "Zillow Agency"])
    end
  end
end
