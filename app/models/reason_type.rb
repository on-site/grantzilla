class ReasonType < ApplicationRecord
  default_scope -> { order(description: :asc) }

  def to_s
    description
  end
end
