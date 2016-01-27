class Grant < ActiveRecord::Base
  has_many :grant_reasons
  has_many :grant_coverage_types

  has_many :coverage_types, through: :grant_coverage_types
  has_many :reason_types, through: :grant_reasons

  has_many :other_payments
  has_many :payee
  has_many :people
  has_one :subsidy_type
end
