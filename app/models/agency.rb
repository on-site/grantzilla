class Agency < ActiveRecord::Base
  has_many :users

  def self.find_hif
    where(name: "HIF").first
  end

  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end
end
