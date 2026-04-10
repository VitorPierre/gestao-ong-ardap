class Person < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  has_many :adoptions
  has_many :foster_cares
  has_one :volunteer

  has_many :document_links, as: :documentable, dependent: :destroy
  has_many :documents, through: :document_links
end
