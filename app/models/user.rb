class User < ApplicationRecord
  include NormalizesDocuments
  
  has_secure_password

  enum :role, { admin: 0, operator: 1, viewer: 2 }

  belongs_to :created_by, class_name: 'User', optional: true

  validates :name, presence: true, length: { maximum: 120 }
  validates :role, presence: true
  validates :email, presence: true, uniqueness: true, strict_email: true, length: { maximum: 254 }

  scope :active, -> { where(active: true) }
end
