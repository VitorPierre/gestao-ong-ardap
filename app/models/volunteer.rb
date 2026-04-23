class Volunteer < ApplicationRecord
  belongs_to :person
  
  validates :activity_type, length: { maximum: 120 }, allow_blank: true
  validates :availability, length: { maximum: 255 }, allow_blank: true
end
