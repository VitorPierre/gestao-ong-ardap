class FosterCare < ApplicationRecord
  belongs_to :person
  belongs_to :animal

  enum :status, { active: 0, completed: 1, cancelled: 2 }
end
