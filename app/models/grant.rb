class Grant < ActiveRecord::Base
  has_many :grant_reasons

  has_many :coverage_types, class_name: "GrantCoverageType"

  has_many :reason_types, through: :grant_reasons

  has_many :other_payments
  has_many :payees
  has_many :people
  has_one :subsidy_type

  belongs_to :residence

  belongs_to(
    :previous_residence,
    class_name: "Residence",
    foreign_key: :previous_residence_id
  )
end
