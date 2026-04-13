class Animal < ApplicationRecord
  enum :species, { dog: 0, cat: 1, other: 2 }
  enum :gender, { male: 0, female: 1, unknown: 2 }
  enum :size, { small: 0, medium: 1, large: 2 }
  enum :status, { available: 0, adopted: 1, in_foster_care: 2, medical_treatment: 3, inactive: 4 }

  validates :name, presence: true
  validates :species, presence: true

  has_many :adoptions
  has_many :foster_cares, dependent: :destroy
  has_many :complaints, dependent: :destroy

  has_many :health_records, dependent: :destroy
  has_many :vaccination_records, dependent: :destroy
  has_many :deworming_records, dependent: :destroy
  has_many :medication_records, dependent: :destroy
  has_many :weight_records, dependent: :destroy

  has_many :document_links, as: :documentable, dependent: :destroy
  has_many :documents, through: :document_links
end
