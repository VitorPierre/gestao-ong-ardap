class Admin::VolunteersController < Admin::BaseController
  before_action :set_volunteer, only: %i[ show edit update destroy ]

  def index
    @volunteers = Volunteer.all.includes(:person).order(created_at: :desc)
  end

  def show
  end

  def new
    @volunteer = Volunteer.new
  end

  def edit
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    if @volunteer.save
      redirect_to admin_volunteers_path, notice: "Voluntário cadastrado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @volunteer.update(volunteer_params)
      redirect_to admin_volunteer_path(@volunteer), notice: "Voluntário atualizado com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @volunteer.destroy!
    redirect_to admin_volunteers_path, notice: "Voluntário removido com sucesso.", status: :see_other
  end

  private

  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  def volunteer_params
    params.require(:volunteer).permit(:person_id, :availability, :activity_type, :image_use_authorized)
  end
end
