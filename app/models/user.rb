class User < ActiveRecord::Base
  devise :confirmable,
         :database_authenticatable,
         :lockable,
         :registerable,
         :recoverable,
         :rememberable,
         :timeoutable,
         :trackable,
         :validatable

  after_create :send_admin_mail

  belongs_to :agency

  def self.case_workers_by_agency(agency = nil)
    case_workers.where(agency: agency)
  end

  def self.case_workers
    where(role: :case_worker)
  end

  def self.send_reset_password_instructions(attributes = {})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  def send_admin_mail
    # AdminMailer.new_user_waiting_for_approval(self).deliver
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    role == 'admin'
  end

  def case_worker?
    role == 'case_worker'
  end

  after_commit :send_pending_notifications

  protected

  def send_devise_notification(notification, *args)
    # If the record is new or changed then delay the
    # delivery until the after_commit callback otherwise
    # send now because after_commit will not be called.
    if new_record? || changed?
      pending_notifications << [notification, args]
    else
      devise_mailer.send(notification, self, *args).deliver_later
    end
  end

  def send_pending_notifications
    pending_notifications.each do |notification, args|
      devise_mailer.send(notification, self, *args).deliver_later
    end

    # Empty the pending notifications array because the
    # after_commit hook can be called multiple times which
    # could cause multiple emails to be sent.
    pending_notifications.clear
  end

  def pending_notifications
    @pending_notifications ||= []
  end
end
