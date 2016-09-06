# frozen_string_literal: true
class Person < ApplicationRecord
  has_many :employments
  has_many :incomes
  belongs_to :grant

  after_initialize :initialize_person_type

  accepts_nested_attributes_for(:incomes, reject_if: :all_blank, allow_destroy: true)

  ADULT = "Adult"
  DEPENDENT = "Dependent"

  DAYCARE = "Daycare"
  FULL_TIME_STUDENT = "Full-Time Student"
  PART_TIME_STUDENT = "Part-Time Student"
  DEPENDENT_STUDENT_STATUSES = [DAYCARE, PART_TIME_STUDENT, FULL_TIME_STUDENT].freeze
  STUDENT_STATUSES = [PART_TIME_STUDENT, FULL_TIME_STUDENT].freeze

  EMPLOYED = "Employed"
  UNEMPLOYED = "Unemployed - Able to work"
  UNABLE_TO_WORK = "Unable to work"
  EMPLOYMENT_STATUSES = [EMPLOYED, UNEMPLOYED, UNABLE_TO_WORK].freeze

  validates :person_type, inclusion: [ADULT, DEPENDENT]
  validates :student_status, inclusion: STUDENT_STATUSES, if: :validate_student_status?
  validates :student_status, inclusion: DEPENDENT_STUDENT_STATUSES, if: :validate_dependent_student_status?
  validates :employment_status, inclusion: EMPLOYMENT_STATUSES, if: :validate_employment_status?

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

  def validate_employment_status?
    adult? && employment_status.present?
  end

  def validate_student_status?
    adult? && student_status.present?
  end

  def validate_dependent_student_status?
    dependent? && student_status.present?
  end
end
