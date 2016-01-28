# frozen_string_literal: true

class Upload < ActiveRecord::Base
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
