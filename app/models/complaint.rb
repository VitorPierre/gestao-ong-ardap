class Complaint < ApplicationRecord
  belongs_to :animal, optional: true
  has_many :complaint_updates, dependent: :destroy
  
  has_many :document_links, as: :documentable, dependent: :destroy
  has_many :documents, through: :document_links

  enum :category, {
    abuse: 0,
    abandonment: 1,
    accident: 2,
    other: 3
  }

  enum :status, {
    new_status: 0, 
    investigating: 1,
    resolved: 2,
    archived: 3,
    unfounded: 4
  }

  enum :priority, {
    normal: 0,
    urgent: 1,
    critical: 2
  }

  validates :description, presence: true
  validates :received_at, presence: true
  validates :complainant_name, presence: true, unless: :anonymous?
  validates :complainant_phone, presence: true, unless: :anonymous?

  before_validation :generate_protocol_number, on: :create
  before_validation :set_received_at, on: :create

  private

  def generate_protocol_number
    return if protocol_number.present?

    year = Date.current.year
    last_complaint = Complaint.where("protocol_number LIKE ?", "DEN-#{year}-%").order(:id).last
    
    seq = if last_complaint
            last_complaint.protocol_number.split("-").last.to_i + 1
          else
            1
          end
          
    self.protocol_number = "DEN-#{year}-#{seq.to_s.rjust(5, '0')}"
  end

  def set_received_at
    self.received_at ||= Time.current
  end
end
