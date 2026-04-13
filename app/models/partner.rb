class Partner < ApplicationRecord
  has_many :donations, dependent: :nullify

  enum :partnership_type, {
    financial: 0,
    supplies: 1,
    service: 2,
    volunteer: 3
  }

  enum :status, {
    active: 0,
    inactive: 1,
    potential: 2
  }

  validates :name, presence: true
  validates :status, presence: true
end
