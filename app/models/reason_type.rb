class ReasonType < ActiveRecord::Base
  default_scope -> { order(description: :asc) }

  def to_s
    description
  end
end
