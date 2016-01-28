class Grant < ActiveRecord::Base
  has_many :grant_reasons, autosave: true
  has_many :reason_types, through: :grant_reasons, autosave: true
  has_many :coverage_types, class_name: "GrantCoverageType"

  has_many :people, autosave: true

  has_many :other_payments
  has_many :payees
  has_one :subsidy_type

  belongs_to :residence

  belongs_to(
    :previous_residence,
    class_name: "Residence",
    foreign_key: :previous_residence_id
  )

  accepts_nested_attributes_for :people, :grant_reasons
end
