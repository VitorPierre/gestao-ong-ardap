class Adoption < ApplicationRecord
  belongs_to :person
  belongs_to :animal

  enum :status, { pending: 0, approved: 1, rejected: 2, completed: 3 }

  has_many :document_links, as: :documentable, dependent: :destroy
  has_many :documents, through: :document_links
end
