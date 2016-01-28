class Residence < ActiveRecord::Base
  has_one :residence_type
  has_one :grant
end
