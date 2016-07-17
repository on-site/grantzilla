class ResidenceType < ApplicationRecord
  has_many :residences

  def to_s
    description
  end
end
