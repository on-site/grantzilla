class Residence < ApplicationRecord
  belongs_to :residence_type
  has_one :grant
end
