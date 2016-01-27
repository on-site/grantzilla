class Grant < ActiveRecord::Base
  has_many :grant_reasons
  has_many :reason_types, through: :grant_reasons
  has_many :people
end
