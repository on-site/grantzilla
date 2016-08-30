# frozen_string_literal: true
require "rails_helper"

RSpec.describe Person, type: :model do
  let(:person) { build(:person) }
  context "current income methods" do
    before do
      person.incomes = [build(:income, :previous, monthly_income: 1000),
                        build(:income, monthly_income: 2000),
                        build(:income, :disability, monthly_income: 3000)]
    end
    describe "#current_earned_income" do
      it "calculates correctly" do
        expect(person.current_earned_income).to eq(2000)
      end
    end
    describe "#current_income" do
      it "calculates correctly" do
        expect(person.current_income).to eq(5000)
      end
    end
    describe "#current_unearned_income" do
      it "calculates correctly" do
        expect(person.current_unearned_income).to eq(3000)
      end
    end
  end
end
