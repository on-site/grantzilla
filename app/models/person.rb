class Person < ActiveRecord::Base
  has_many :employments
  has_many :incomes
  belongs_to :grant

  def name=(value)
    self.first_name, self.last_name, *more_names = value.split(' ')
    self.last_name += [''].concat(more_names).join(' ')
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
