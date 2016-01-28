class Person < ActiveRecord::Base
  has_many :employments
  has_many :incomes
  belongs_to :grant

  def full_name
    "#{first_name} #{last_name}"
  end

  def student_status
    return "Full Time Student" if student && full_time_student
    return "Part Time Student" if student
    "None"
  end
end
