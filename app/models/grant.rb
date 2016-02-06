class Grant < ActiveRecord::Base
  COMPONENTS = [:grants_reason_types, :people, :payees].freeze

  before_save :set_application_date

  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :coverage_types
  has_and_belongs_to_many :payees

  default_scope -> { order(application_date: :desc) }

  belongs_to :user
  belongs_to :subsidy_type
  belongs_to :status, class_name: "GrantStatus", foreign_key: :grant_status_id
  belongs_to :residence
  belongs_to :previous_residence, class_name: "Residence", foreign_key: :previous_residence_id
  belongs_to :last_month_budget, class_name: "Budget"
  belongs_to :current_month_budget, class_name: "Budget"
  belongs_to :next_month_budget, class_name: "Budget"

  has_many :people, autosave: true
  has_many :other_payments
  has_many :comments
  has_many :grants_reason_types
  has_many :reason_types, through: :grants_reason_types

  delegate :agency, to: :user

  accepts_nested_attributes_for(*COMPONENTS, reject_if: :all_blank, allow_destroy: true)

  def self.list
    order(application_date: :desc)
      .includes(user: :agency).includes(:people).all
      .to_json(only: [:id, :ehf_number, :application_date],
               methods: [
                 :primary_applicant_name,
                 :agency_name,
                 :case_worker_name,
                 :status_name
               ])
  end

  def status_name
    raise "Grant can not have blank grant status" if status.blank?
    status.description
  end

  def set_application_date
    return if application_date.present?
    self.application_date = Time.zone.today
  end

  def primary_applicant
    people.first
  end

  def primary_applicant_name
    primary_applicant.full_name if primary_applicant.present?
  end

  def agency_name
    return "" unless agency.present?
    agency.name
  end

  def case_worker_name
    return "" unless user.present?
    user.full_name
  end

  def grant_amount=(value)
    self[:grant_amount] = value.to_s.delete("$,")
  end
end
