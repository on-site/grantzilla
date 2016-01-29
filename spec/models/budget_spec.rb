require 'rails_helper'

RSpec.describe Budget, type: :model do
  describe "#create" do
    let(:grant) { Grant.create total_rent: 1000.0 }
    let(:person) { grant.people.build }
    let(:person2) { grant.people.build }
    let(:person3) { grant.people.build }
    let(:budget) { grant.create_last_month_budget }
    before do
      allow(person).to receive(:current_earned_income).and_return(2000.0)
      allow(person).to receive(:current_unearned_income).and_return(3000.0)
      allow(person2).to receive(:current_earned_income).and_return(1500.0)
      allow(person2).to receive(:current_unearned_income).and_return(500.0)
      allow(person3).to receive(:current_income).and_return(250.0)
    end
    it "initializes the rent" do
      expect(budget.rent).to eq(1000.0)
    end
    it "initializes the primary earned income" do
      expect(budget.earned_income1).to eq(2000.0)
    end
    it "initializes the primary unearned income" do
      expect(budget.unearned_income1).to eq(3000.0)
    end
    it "initializes the secondary earned income" do
      expect(budget.earned_income2).to eq(1500.0)
    end
    it "initializes the secondary unearned income" do
      expect(budget.unearned_income2).to eq(500.0)
    end
    it "initializes the other household member income" do
      expect(budget.other_household_income).to eq(250.0)
    end
  end
end
