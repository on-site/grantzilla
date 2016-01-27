class Person < ActiveRecord::Base
  has_many :employments
  has_many :incomes
  belongs_to :grant
end
