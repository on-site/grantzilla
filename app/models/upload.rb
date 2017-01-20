# frozen_string_literal: true

class Upload < ApplicationRecord
  VALID_CONTENT_TYPES = [
    "application/pdf",
    "application/vnd.ms-excel",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    "application/msword",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "image/jpeg",
    "image/gif",
    "image/png",
    "text/plain"
  ].freeze

  UPLOAD_CATEGORIES = {
    "W-9 from Landlord" => "W-9 from Landlord",
    "Lease Agreement" => "Relevant pages of lease (pages that show name of
        lessees, rental amount, security deposit amount, rental dates, and
        signatures of lessees and payee).  If a lease has not been signed,
        an Acknowledgement to Rent can be submitted in lieu of a lease.",
    "Verification of Owed Amounts" => "Verification of owed costs
        (3-Day Notice or other written verification of exactly what
        lessee owes)",
    "Verification of Income" => "Verification of income for every
        adult (pay stubs, letter verifying employment, benefits award
        letter, etc)",
    "Verification of Crisis" => "Verification of crisis (car repair
        bill, copy of no-fault notice to vacate, verification of illness)"
  }.freeze

  belongs_to :user, polymorphic: true
  has_attached_file :file
  validates_attachment :file,
                       presence: true,
                       size: { in: 0..2.megabytes },
                       content_type: { content_type: VALID_CONTENT_TYPES }

  validates :user, presence: { if: :new_record? }
  validates :user, presence: { if: :user_id_changed? }
  validates :user, presence: { if: :user_type_changed? }
end
