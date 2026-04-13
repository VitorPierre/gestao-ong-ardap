class HealthRecord < ApplicationRecord
  belongs_to :animal

  enum :record_type, {
    consultation:   0,
    surgery:        1,
    exam:           2,
    hospitalization: 3,
    other:          4
  }

  enum :status, {
    done:      0,
    scheduled: 1,
    canceled:  2
  }

  has_many :document_links, as: :documentable, dependent: :destroy
  has_many :documents, through: :document_links

  validates :occurred_at, presence: true
  validates :description, presence: true
end
