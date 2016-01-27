class GrantReason < ActiveRecord::Base
  belongs_to :reason_type
  belongs_to :grant
end
