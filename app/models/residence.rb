class Residence < ActiveRecord::Base
  belongs_to :residence_type
  has_one :grant
end
