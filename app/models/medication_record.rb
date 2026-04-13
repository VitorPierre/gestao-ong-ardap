class MedicationRecord < ApplicationRecord
  belongs_to :animal

  enum :status, {
    in_use: 0,
    completed: 1,
    suspended: 2
  }

  validates :medication_name, presence: true
  validates :start_date, presence: true
  validates :status, presence: true
end
