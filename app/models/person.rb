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

  AMERICAN_INDIAN_AND_ALASKA_NATIVE = "American_Indian and Alaska Native"
  ASIAN = "Asian"
  BLACK = "Black"
  HISPANIC_AND_LATINO = "Hispanic and Latino"
  MULTIRACIAL = "Multiracial"
  NATIVE_HAWAIIAN_AND_OTHER_PACIFIC_ISLANDER = "Native Hawaiian and Other Pacific Islander"
  WHITE = "White"
  PREFER_NOT_TO_SAY = "Prefer Not to Say"
  ETHNICITY = [AMERICAN_INDIAN_AND_ALASKA_NATIVE, ASIAN, BLACK, HISPANIC_AND_LATINO,
               MULTIRACIAL, NATIVE_HAWAIIAN_AND_OTHER_PACIFIC_ISLANDER, WHITE,
               PREFER_NOT_TO_SAY].freeze

  INCOME_LESS_THAN_25000 = "Less than $25,000"
  INCOME_25000_34999 = "$25,000 to $34,999"
  INCOME_35000_49999 = "$35,000 to $49,999"
  INCOME_50000_74999 = "$50,000 to $74,999"
  INCOME_75000_99999 = "$75,000 to $99,999"
  INCOME_100000_149999 = "$100,000 to $149,999"
  INCOME_150000_MORE = "$150,000 or more"
  HOUSEHOLD_INCOME = [INCOME_LESS_THAN_25000, INCOME_25000_34999, INCOME_35000_49999,
                      INCOME_50000_74999, INCOME_75000_99999, INCOME_100000_149999,
                      INCOME_150000_MORE].freeze

  AGE_UNDER_18_YEARS = "Under 18 years"
  AGE_18_24_YEARS = "18 to 24 years"
  AGE_25_34_YEARS = "25 to 34 years"
  AGE_35_44_YEARS = "35 to 44 years"
  AGE_45_54_YEARS = "45 to 54 years"
  AGE_55_64_YEARS = "55 to 64 years"
  AGE_65_OLDER = "Age 65 or older"
  AGE_GROUP = [AGE_UNDER_18_YEARS, AGE_18_24_YEARS, AGE_25_34_YEARS, AGE_35_44_YEARS,
               AGE_45_54_YEARS, AGE_55_64_YEARS, AGE_65_OLDER].freeze

  EDUCATION_LESS_THAN_HIGH_SCHOOL = "Less than high school"
  EDUCATION_HIGH_SCHOOL = "High school graduate (includes equivalency)"
  EDUCATION_SOME_COLLEGE = "Some college, no degree"
  EDUCATION_ASSOCIATE_DEGREE = "Associate's degree"
  EDUCATION_BACHELOR_DEGREE = "Bachelor's degree"
  EDUCATION_PHD = "Ph.D."
  EDUCATION_GRADUATE_PROFESSIONAL_DEGREE = "Graduate or professional degree"
  EDUCATION_LEVEL = [EDUCATION_LESS_THAN_HIGH_SCHOOL, EDUCATION_HIGH_SCHOOL,
                     EDUCATION_SOME_COLLEGE, EDUCATION_ASSOCIATE_DEGREE,
                     EDUCATION_BACHELOR_DEGREE, EDUCATION_PHD,
                     EDUCATION_GRADUATE_PROFESSIONAL_DEGREE].freeze

  GENDER_FEMALE = "Female"
  GENDER_MALE = "Male"
  GENDER = [GENDER_FEMALE, GENDER_MALE].freeze

  DISABILITY_NO = "No"
  DISABILITY_YES = "Yes"
  DISABILITY = [DISABILITY_NO, DISABILITY_YES].freeze

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
