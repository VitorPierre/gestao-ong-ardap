class VaccinationRecord < ApplicationRecord
  belongs_to :animal

  validates :vaccine_name, presence: true
  validates :administered_at, presence: true
end
