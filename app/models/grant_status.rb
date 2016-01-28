class GrantStatus < ActiveRecord::Base
  has_many :grants

  def self.initial
    find(1) # id 1 guaranteed by 20160128040438_add_grant_status_data.rb
  end
end
