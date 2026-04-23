class DocumentParticipant < ApplicationRecord
  belongs_to :document

  validates :full_name, presence: true
  validates :role_in_document, presence: true

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
end
