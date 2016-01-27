class Grant < ActiveRecord::Base
  has_many :grant_reasons, autosave: true
  has_many :reason_types, through: :grant_reasons, autosave: true
  has_many :people, autosave: true

  accepts_nested_attributes_for :people, :grant_reasons
end
