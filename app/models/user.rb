class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  belongs_to :agency

  def self.case_workers_by_agency(agency = nil)
    case_workers.where agency: agency
  end

  def self.case_workers
    where role: "case_worker"
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
end
