class Admin::ComplaintsController < Admin::BaseController
  before_action :set_complaint, only: [:show, :edit, :update, :destroy]

  def index
    @complaints = Complaint.all.includes(:animal).order(received_at: :desc)
    
    if params[:status].present?
      @complaints = @complaints.where(status: params[:status])
    end
    
    if params[:category].present?
      @complaints = @complaints.where(category: params[:category])
    end
  end

  def show
    @complaint_updates = @complaint.complaint_updates.order(created_at: :desc)
    @new_update = @complaint.complaint_updates.new
  end

  def new
    @complaint = Complaint.new(received_at: Time.current)
  end

  def edit
  end

  def create
    @complaint = Complaint.new(complaint_params)
    if @complaint.save
      redirect_to admin_complaint_path(@complaint), notice: "Denúncia registrada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @complaint.update(complaint_params)
      redirect_to admin_complaint_path(@complaint), notice: "Denúncia atualizada com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @complaint.destroy!
    redirect_to admin_complaints_path, notice: "Denúncia removida.", status: :see_other
  end

  private

  def set_complaint
    @complaint = Complaint.find(params[:id])
  end

  def complaint_params
    params.require(:complaint).permit(
      :category, :description, :location_address, :location_city, :location_reference,
      :complainant_name, :complainant_phone, :anonymous, :status, :priority, 
      :received_at, :assigned_to, :animal_id, :notes
    )
  end
end
