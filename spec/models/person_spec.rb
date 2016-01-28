require "rails_helper"

RSpec.describe Person, type: :model do
  let(:person) { Person.new }
  context "current income methods" do
    before do
      person.incomes.build(current: false, disabled: false, monthly_income: 1000)
      person.incomes.build(current: true, disabled: false, monthly_income: 2000)
      person.incomes.build(current: true, disabled: true, monthly_income: 3000)
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
