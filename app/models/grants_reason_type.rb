class GrantsReasonType < ActiveRecord::Base
  belongs_to :grant
  belongs_to :reason_type
end
