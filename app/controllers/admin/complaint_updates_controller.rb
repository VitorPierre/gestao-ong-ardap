class Admin::ComplaintUpdatesController < Admin::BaseController
  before_action :set_complaint, only: [:create]

  def create
    @update = @complaint.complaint_updates.new(complaint_update_params)
    @update.author = current_user&.name || "Sistema" # Fallback if no user is logged in
    
    if @update.save
      redirect_to admin_complaint_path(@complaint), notice: "Atualização salva com sucesso."
    else
      redirect_to admin_complaint_path(@complaint), alert: "Erro ao salvar atualização: #{@update.errors.full_messages.to_sentence}"
    end
  end

  private

  def set_complaint
    @complaint = Complaint.find(params[:complaint_id])
  end

  def complaint_update_params
    params.require(:complaint_update).permit(:description, :status_changed_to)
  end
end
