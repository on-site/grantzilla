class Person < ActiveRecord::Base
  has_many :employments
  has_many :incomes
  belongs_to :grant

  def full_name
    "#{first_name} #{last_name}"
  end
end
