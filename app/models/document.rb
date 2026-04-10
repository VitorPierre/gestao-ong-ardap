class Document < ApplicationRecord
  has_one_attached :file

  has_many :document_links, dependent: :destroy
  has_many :people, through: :document_links, source: :documentable, source_type: 'Person'
  has_many :animals, through: :document_links, source: :documentable, source_type: 'Animal'
  has_many :adoptions, through: :document_links, source: :documentable, source_type: 'Adoption'

  validates :title, presence: true
end
