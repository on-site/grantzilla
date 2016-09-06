# frozen_string_literal: true
require "rails_helper"

RSpec.describe Person, type: :model do
  let(:person) { build(:person) }
  context "validations" do
    let(:subject) { person }
    context "when the person type is invalid" do
      let(:person) { build(:person, person_type: "Invalid") }
      it "is considered invalid" do
        expect(subject).to_not be_valid
      end
    end
    context "when the employment status is invalid" do
      let(:person) { build(:person, person_type: Person::ADULT, employment_status: "Invalid") }
      it "is considered invalid" do
        expect(subject).to_not be_valid
      end
    end
    context "when the student status is invalid" do
      let(:person) { build(:person, person_type: Person::ADULT, student_status: "Invalid") }
      it "is considered invalid" do
        expect(subject).to_not be_valid
      end
    end
  end
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
