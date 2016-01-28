class Grant < ActiveRecord::Base
  # Descriptors
  belongs_to :user
  has_many :grant_reasons, autosave: true
  has_many :reason_types, through: :grant_reasons, autosave: true
  has_many :grant_coverage_types
  has_many :coverage_types, through: :grant_coverage_types
  before_save :set_application_date

  belongs_to :subsidy_type
  belongs_to(
    :status,
    class_name: "GrantStatus",
    foreign_key: :grant_status_id
  )

  # Components
  has_many :people, autosave: true
  has_many :other_payments
  has_many :payees

  belongs_to :residence
  belongs_to(
    :previous_residence,
    class_name: "Residence",
    foreign_key: :previous_residence_id
  )

  belongs_to :last_month_budget, class_name: "Budget"
  belongs_to :current_month_budget, class_name: "Budget"
  belongs_to :next_month_budget, class_name: "Budget"

  accepts_nested_attributes_for :people, :grant_reasons

  def set_application_date
    self.application_date = Time.zone.today
  end
end
