require "rails_helper"

RSpec.describe Agency, type: :model do
  describe "#full_address" do
    let(:attributes) { { name: "acme agency" } }
    let(:agency) { Agency.new attributes }
    context "agency record includes all address fields" do
      let(:attributes) do
        { name: "acme agency",
          address: "123 Main Street",
          city: "San Jose",
          state: "CA",
          zip: "95123" }
      end
      it "provides a properly formated full address" do
        expect(agency.full_address).to eq("123 Main Street, San Jose, CA 95123")
      end
    end
  end

  describe ".ordered_agencies" do
    before do
      Agency.create(name: "Zillow Agency")
      Agency.create(name: "Acme Agency")
    end

    it "lists all agecies in alphabetical order" do
      expect(Agency.ordered_agencies.map(&:name)).to eq(["Acme Agency", "Zillow Agency"])
    end
  end
end
