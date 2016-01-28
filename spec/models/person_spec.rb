require "rails_helper"

def create_income(current, disabled, monthly_income)
  instance_double(Income, current: current, disabled: disabled, monthly_income: monthly_income)
end

RSpec.describe Person, type: :model do
  let(:person) { Person.new }
  context "current income methods" do
    before do
      allow(person).to receive(:incomes).and_return [
        create_income(false, false, 1000),
        create_income(true, false, 2000),
        create_income(true, true, 3000)]
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
