class Document < ApplicationRecord
  attribute :status, :string, default: "draft"
  attribute :category, :string
  attribute :document_type, :string

  has_one_attached :file

  has_many :document_links, dependent: :destroy
  has_one :document_signature, dependent: :destroy
  
  belongs_to :linked, polymorphic: true, optional: true
  belongs_to :signed_by_user, class_name: "User", optional: true
  belongs_to :creator_user, class_name: "User", optional: true
  
  has_many :document_participants, dependent: :destroy
  accepts_nested_attributes_for :document_participants, allow_destroy: true

  has_many :people, through: :document_links, source: :documentable, source_type: 'Person'
  has_many :animals, through: :document_links, source: :documentable, source_type: 'Animal'
  has_many :adoptions, through: :document_links, source: :documentable, source_type: 'Adoption'

  enum :status, {
    draft: "draft",
    generated: "generated",
    signed: "signed",
    canceled: "canceled"
  }

  enum :category, {
    adoption: "adoption",
    foster_care: "foster_care",
    volunteering: "volunteering",
    animal: "animal",
    person: "person",
    donation: "donation",
    complaint: "complaint"
  }

  enum :document_type, {
    adoption_term: "adoption_term",
    adoption_questionnaire: "adoption_questionnaire",
    foster_care_term: "foster_care_term",
    foster_care_report: "foster_care_report",
    volunteer_term: "volunteer_term",
    image_authorization: "image_authorization",
    animal_registration: "animal_registration",
    castration_declaration: "castration_declaration",
    veterinary_report: "veterinary_report",
    veterinary_prescription: "veterinary_prescription",
    person_registration: "person_registration",
    donation_receipt: "donation_receipt",
    partnership_term: "partnership_term",
    complaint_report: "complaint_report",
    complaint_occurrence: "complaint_occurrence"
  }

  validates :title, presence: true
  validates :creator_user, presence: true, on: :create
  validates :document_participants, presence: true, on: :create

  scope :by_category, ->(cat) { where(category: cat) }
  scope :signed, -> { where(status: "signed") }
  scope :pending_signature, -> { where(status: "generated") }
  scope :draft, -> { where(status: "draft") }

  validate :readonly_if_locked, on: :update

  def signature_stamp
    return nil unless signed? && document_signature.present?
    
    [
      "Documento assinado eletronicamente",
      "Signatário: #{document_signature.signer_name}",
      "Data e hora: #{document_signature.signed_at.strftime('%d/%m/%Y %H:%M:%S')}",
      "Hash SHA256: #{document_signature.content_hash[0..15]}...",
      "Assinado via sistema administrativo da ONG ARDAP"
    ]
  end

  private

  def readonly_if_locked
    if is_locked_was && (content_changed? || hash_signature_changed? || signer_name_changed?)
      errors.add(:base, "Documento bloqueado após assinatura eletrônica e não pode ser alterado.")
    end
  end
end
