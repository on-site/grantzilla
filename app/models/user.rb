class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :confirmable,
         :database_authenticatable,
         :lockable,
         :registerable,
         :recoverable,
         :rememberable,
         :timeoutable,
         :trackable,
         :validatable

  belongs_to :agency

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
