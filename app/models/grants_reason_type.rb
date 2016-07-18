# frozen_string_literal: true
class GrantsReasonType < ApplicationRecord
  belongs_to :grant
  belongs_to :reason_type
end
