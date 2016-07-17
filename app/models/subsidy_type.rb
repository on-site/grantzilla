class SubsidyType < ApplicationRecord
  has_many :grants

  def to_s
    description
  end
end
