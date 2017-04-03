# frozen_string_literal: true
class Person < ApplicationRecord
  has_many :employments
  has_many :incomes
  belongs_to :grant

  after_initialize :initialize_person_type

  accepts_nested_attributes_for(:incomes, reject_if: :all_blank, allow_destroy: true)

  ADULT = "Adult"
  DEPENDENT = "Dependent"

  def adult?
    person_type == ADULT
  end

  def dependent?
    person_type == DEPENDENT
  end

  def current_earned_income
    incomes.select(&:current).reject(&:disabled).map(&:monthly_income).sum
  end

  def current_income
    incomes.select(&:current).map(&:monthly_income).sum
  end

  def current_unearned_income
    incomes.select(&:current).select(&:disabled).map(&:monthly_income).sum
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_s
    full_name
  end

  private

  def initialize_person_type
    self.person_type = ADULT unless person_type.present?
  end
end
