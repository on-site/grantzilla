class Income < ActiveRecord::Base
  belongs_to :person
  belongs_to :income_type
end
