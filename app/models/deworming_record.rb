class DewormingRecord < ApplicationRecord
  belongs_to :animal

  validates :product_name, presence: true
  validates :administered_at, presence: true
end
