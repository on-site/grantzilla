class GrantCoverageType < ActiveRecord::Base
  belongs_to :coverage_type
  belongs_to :grant
end
