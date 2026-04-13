class Admin::FosterCaresController < Admin::BaseController
  before_action :set_foster_care, only: %i[ show edit update destroy ]

  def index
    @foster_cares = FosterCare.all.includes(:person, :animal).order(created_at: :desc)
  end

  def show
  end

  def new
    @foster_care = FosterCare.new
  end

  def edit
  end

  def create
    @foster_care = FosterCare.new(foster_care_params)
    if @foster_care.save
      redirect_to admin_foster_cares_path, notice: "Lar temporário registrado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @foster_care.update(foster_care_params)
      redirect_to admin_foster_care_path(@foster_care), notice: "Lar temporário atualizado com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @foster_care.destroy!
    redirect_to admin_foster_cares_path, notice: "Lar temporário removido com sucesso.", status: :see_other
  end

  private

  def set_foster_care
    @foster_care = FosterCare.find(params[:id])
  end

  def foster_care_params
    params.require(:foster_care).permit(:person_id, :animal_id, :start_date, :end_date, :status, :notes)
  end
end
