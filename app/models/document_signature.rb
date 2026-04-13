class DocumentSignature < ApplicationRecord
  belongs_to :document
  belongs_to :user, optional: true

  validates :signer_name, presence: true
  validates :signer_ip, presence: true
  validates :accepted_terms, inclusion: { in: [true] }
  validates :content_hash, presence: true
  validates :signed_at, presence: true
end
