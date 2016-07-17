# frozen_string_literal: true
class Income < ApplicationRecord
  belongs_to :person
  belongs_to :income_type
end
