class CoverageType < ActiveRecord::Base
  has_many :grant_coverage_types
  has_many :grants, through: :grant_coverage_types
end
