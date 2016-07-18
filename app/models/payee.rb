# frozen_string_literal: true
class Payee < ApplicationRecord
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :grants
end
