class Payee < ApplicationRecord
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :grants
end
