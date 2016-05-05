class Grant < ActiveRecord::Base
  COMPONENTS = [:grants_reason_types, :people, :residence, :payees].freeze

  before_save :set_application_date
  before_create :set_initial_status

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
  has_many :uploads
  has_many :reason_types, through: :grants_reason_types

  delegate :agency, to: :user

  accepts_nested_attributes_for(*COMPONENTS, reject_if: :all_blank, allow_destroy: true)

  scope :by_agency_id, -> (agency_id) { joins(:user).where(users: { agency_id: agency_id }) if agency_id.present? }
  scope :by_user_id, -> (user_id) { where(user_id: user_id) if user_id.present? }
  scope :search, (lambda do |search|
    if search.present?
      joins(:people)
        .where("LOWER(people.first_name || ' ' || people.last_name) LIKE ?",
               "%#{search.downcase}%")
    end
  end)
  scope :visible_for_user, (lambda do |user|
    unless user.admin?
      if user.approved
        joins(:user).where(users: { agency_id: user.agency_id })
      else
        where(user_id: user.id)
      end
    end
  end)

  def intialize_defaults(options = {})
    self.user_id = options[:user_id] if user_id.nil?
    people.build if people.empty?
    payees.build if payees.empty?
    build_residence unless residence.present?
  end

  def self.list(current_user, options = {})
    joins(:people, :status, user: :agency)
      .search(options[:search])
      .by_agency_id(options[:agency_id])
      .by_user_id(options[:user_id])
      .visible_for_user(current_user)
      .order(id: :desc)
  end

  def status_name
    raise "Grant can not have blank grant status" if status.blank?
    status.description
  end

  def primary_applicant
    people.first
  end

  def primary_applicant_name
    primary_applicant.full_name if primary_applicant.present?
  end

  def agency_name
    return "" unless user.present? && agency.present?
    agency.name
  end

  def case_worker_name
    return "" unless user.present?
    user.full_name
  end

  def grant_amount=(value)
    self[:grant_amount] = value.to_s.delete("$,")
  end

  private

  def set_application_date
    return if application_date.present?
    self.application_date = Time.zone.today
  end

  def set_initial_status
    return if status.present?
    self.status = GrantStatus.initial
  end
end
