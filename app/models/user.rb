class User < ApplicationRecord
  has_secure_password

  enum :role, { admin: 0, operator: 1, viewer: 2 }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
