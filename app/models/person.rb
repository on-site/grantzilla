class Person < ActiveRecord::Base
  has_many :employments
  has_many :incomes
  belongs_to :grant

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

  def student_status
    return "Full Time Student" if student && full_time_student
    return "Part Time Student" if student
    "None"
  end
end
