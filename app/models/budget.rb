class Budget < ApplicationRecord
  has_one :grant
  before_create :initialize_primary_applicant_income
  before_create :initialize_secondary_applicant_income
  before_create :initialize_additional_applicant_income
  before_create :initialize_rent

  def initialize_primary_applicant_income
    return unless grant.people.first.present?
    self.earned_income1 ||= grant.people.first.current_earned_income
    self.unearned_income1 ||= grant.people.first.current_unearned_income
  end

  def initialize_secondary_applicant_income
    return unless grant.people.size > 1
    self.earned_income2 ||= grant.people[1].current_earned_income
    self.unearned_income2 ||= grant.people[1].current_unearned_income
  end

  def initialize_additional_applicant_income
    return unless grant.people.size > 2
    self.other_household_income ||= grant.people.slice(2..-1).map(&:current_income).sum
  end

  def initialize_rent
    self.rent ||= grant.total_rent
  end
end
