class Donation < ApplicationRecord
  belongs_to :partner, optional: true
  belongs_to :person, optional: true

  enum :donation_type, {
    financial: 0,
    supplies: 1
  }

  enum :recurrence_interval, {
    monthly: 0,
    quarterly: 1,
    yearly: 2
  }

  enum :payment_method, {
    cash: 0,
    pix: 1,
    transfer: 2,
    other_method: 3
  }

  enum :status, {
    pending: 0,
    confirmed: 1,
    canceled: 2
  }

  validates :donation_type, presence: true
  validates :donated_at, presence: true
  validates :status, presence: true
  validates :payment_method, presence: true

  validate :amount_for_financial
  validate :description_for_supplies

  private

  def amount_for_financial
    if financial? && amount.blank?
      errors.add(:amount, "deve ser preenchido para doações financeiras")
    end
  end

  def description_for_supplies
    if supplies? && description.blank?
      errors.add(:description, "deve ser preenchida para doações em espécie")
    end
  end
end
