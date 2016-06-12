class ResidenceType < ActiveRecord::Base
  has_many :residences

  def to_s
    description
  end
end
