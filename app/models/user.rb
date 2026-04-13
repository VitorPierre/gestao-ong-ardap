class User < ApplicationRecord
  has_secure_password

  enum :role, { admin: 0, operator: 1, viewer: 2 }

  belongs_to :created_by, class_name: 'User', optional: true

  validates :name, presence: true
  validates :role, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :active, -> { where(active: true) }
end
