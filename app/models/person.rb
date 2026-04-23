class Person < ApplicationRecord
  include NormalizesDocuments

  validates :name, presence: true, length: { maximum: 150 }
  validates :email, presence: true, uniqueness: true, strict_email: true, length: { maximum: 254 }, allow_blank: true
  validates :cpf, cpf: true, allow_blank: true, length: { maximum: 11 }
  validates :rg, rg: true, allow_blank: true, length: { maximum: 20 }
  validates :phone, length: { maximum: 20 }, allow_blank: true
  validates :address, length: { maximum: 255 }, allow_blank: true
  validates :city, length: { maximum: 100 }, allow_blank: true
  validates :state, length: { maximum: 2 }, allow_blank: true

  has_many :adoptions
  has_many :foster_cares
  has_one :volunteer

  has_many :document_links, as: :documentable, dependent: :destroy
  has_many :documents, through: :document_links
  has_many :donations, dependent: :nullify
end
