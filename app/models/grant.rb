class Grant < ActiveRecord::Base
  COMPONENTS = [:grants_reason_types, :people, :residence, :payees].freeze

  before_save :set_application_date
  before_create :set_initial_status

  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :coverage_types
  has_and_belongs_to_many :payees

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
  has_many :uploads, as: :user
  has_many :reason_types, through: :grants_reason_types

  delegate :agency, to: :user

  accepts_nested_attributes_for(*COMPONENTS, reject_if: :all_blank, allow_destroy: true)

  self.per_page = 10

  def self.default_scope
    order(application_date: :desc)
  end

  def self.list(current_user, options = {})
    joins(:status, user: :agency)
      .includes(:people, :user, :status)
      .search(options[:search])
      .by_agency_id(options[:agency_id])
      .by_user_id(options[:user_id])
      .visible_for_user(current_user)
      .paginate(page: options[:page])
      .order(id: :desc)
  end

  def self.search(search)
    return all unless search.present?
    where("#{table_name}.id IN (
      SELECT grant_id FROM people
      WHERE LOWER(people.first_name || ' ' || people.last_name) LIKE ?)", "%#{search.downcase}%")
  end

  def self.by_agency_id(agency_id)
    return all unless agency_id.present?
    joins(:user).where(users: { agency_id: agency_id })
  end

  def self.by_user_id(user_id)
    return all unless user_id.present?
    where(user_id: user_id)
  end

  def self.visible_for_user(user)
    return all if user.admin?
    if user.approved
      joins(:user).where(users: { agency_id: user.agency_id })
    else
      where(user_id: user.id)
    end
  end

  def self.find_if_visible(id, current_user)
    return Grant.new if id.to_i == 0
    grant = visible_for_user(current_user).find_by_id(id)
    raise Errors::NotFoundError unless grant.present?
    grant
  end

  def intialize_defaults(options = {})
    self.user_id = options[:user_id] if user_id.nil?
    people.build if people.empty?
    payees.build if payees.empty?
    build_residence unless residence.present?
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
