class ComplaintUpdate < ApplicationRecord
  belongs_to :complaint

  # Para simplificar e evitar metaprogramação pesada, o nome dos status ficarão numéricos se mapeados direto do enum,
  # mas podemos salvar o inteiro ou a string. Vamos salvar o integer correspondente para manter tipagem se for usar.
  # Na migration ficou integer.
  
  validates :description, presence: true, unless: -> { status_changed_to.present? }
  validates :author, presence: true

  after_create :update_complaint_status_if_needed

  private

  def update_complaint_status_if_needed
    return unless status_changed_to.present?
    
    # status_changed_to represents an integer mapped to the Complaint status enum
    complaint.update(status: status_changed_to)
    
    if complaint.resolved? || complaint.archived? || complaint.unfounded?
      complaint.update(resolved_at: Time.current) unless complaint.resolved_at.present?
    end
  end
end
