class Partner < ApplicationRecord
  include NormalizesDocuments

  has_many :donations, dependent: :nullify

  enum :partnership_type, {
    financial: 0,
    supplies: 1,
    service: 2,
    volunteer: 3
  }

  enum :status, {
    active: 0,
    inactive: 1,
    potential: 2
  }

  validates :name, presence: true, length: { maximum: 150 }
  validates :status, presence: true
  validates :contact_name, length: { maximum: 120 }, allow_blank: true
  validates :email, strict_email: true, length: { maximum: 254 }, allow_blank: true
  validates :phone, length: { maximum: 20 }, allow_blank: true
  validates :address, length: { maximum: 255 }, allow_blank: true
  validates :city, length: { maximum: 100 }, allow_blank: true
  validates :state, length: { maximum: 2 }, allow_blank: true
  validates :notes, length: { maximum: 2000 }, allow_blank: true
  
  validate :validate_document_format

  private

  def validate_document_format
    return if document.blank?
    if document.length == 11
      errors.add(:document, "não é um CPF válido") unless CpfValidator.new(attributes: [:document]).send(:cpf_valid?, document)
    elsif document.length == 14
      errors.add(:document, "não é um CNPJ válido") unless CnpjValidator.new(attributes: [:document]).send(:cnpj_valid?, document)
    else
      errors.add(:document, "deve ter 11 (CPF) ou 14 (CNPJ) dígitos")
    end
  end
end
