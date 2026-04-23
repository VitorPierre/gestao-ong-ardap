class DocumentParticipant < ApplicationRecord
  include NormalizesDocuments

  belongs_to :document

  enum :document_kind, {
    cpf: 0,
    cnpj: 1,
    rg: 2,
    other_document: 3
  }

  enum :role_in_document, {
    adopter: 0,
    foster: 1,
    volunteer: 2,
    donor: 3,
    partner: 4,
    witness: 5,
    legal_representative: 6,
    complainant: 7,
    other_role: 8
  }

  enum :external_type, {
    individual: 0,
    organization: 1
  }

  validates :full_name, presence: true, length: { maximum: 150 }
  validates :role_in_document, presence: true
  validates :email, strict_email: true, length: { maximum: 254 }, allow_blank: true
  validates :phone, length: { maximum: 20 }, allow_blank: true
  validates :address, length: { maximum: 255 }, allow_blank: true
  validates :notes, length: { maximum: 1000 }, allow_blank: true
  validates :document_number, length: { maximum: 20 }, allow_blank: true

  validate :validate_contextual_document

  private

  def validate_contextual_document
    return if document_number.blank?
    
    case document_kind
    when 'cpf'
      errors.add(:document_number, "não é um CPF válido") unless CpfValidator.new(attributes: [:document_number]).send(:cpf_valid?, document_number)
    when 'cnpj'
      errors.add(:document_number, "não é um CNPJ válido") unless CnpjValidator.new(attributes: [:document_number]).send(:cnpj_valid?, document_number)
    when 'rg'
      errors.add(:document_number, "não é um RG válido") unless RgValidator.new(attributes: [:document_number]).send(:rg_valid?, document_number)
    end
  end
end
