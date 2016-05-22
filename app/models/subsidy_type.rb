class SubsidyType < ActiveRecord::Base
  has_many :grants

  def to_s
    description
  end
end
