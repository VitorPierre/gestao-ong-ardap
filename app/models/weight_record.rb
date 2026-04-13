class WeightRecord < ApplicationRecord
  belongs_to :animal

  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :measured_at, presence: true
end
