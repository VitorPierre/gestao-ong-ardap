class Admin::HealthRecordsController < Admin::BaseController
  before_action :set_animal, only: [:index, :new, :create]
  before_action :set_health_record, only: [:show, :edit, :update, :destroy]

  def index
    if @animal
      @health_records = @animal.health_records.order(occurred_at: :desc)
    else
      @health_records = HealthRecord.all.includes(:animal).order(occurred_at: :desc)
    end
  end

  def show
  end

  def new
    @health_record = @animal.health_records.new(occurred_at: Date.current)
  end

  def edit
    @animal = @health_record.animal
  end

  def create
    @health_record = @animal.health_records.new(health_record_params)

    if @health_record.save
      redirect_to admin_animal_path(@animal, tab: 'consultations'), notice: "Registro criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @health_record.update(health_record_params)
      redirect_to admin_animal_path(@health_record.animal, tab: 'consultations'), notice: "Registro atualizado com sucesso."
    else
      @animal = @health_record.animal
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    animal = @health_record.animal
    @health_record.destroy!
    redirect_to admin_animal_path(animal, tab: 'consultations'), notice: "Registro removido.", status: :see_other
  end

  private

  def set_animal
    @animal = Animal.find(params[:animal_id]) if params[:animal_id]
  end

  def set_health_record
    @health_record = HealthRecord.find(params[:id])
  end

  def health_record_params
    params.require(:health_record).permit(
      :record_type, :description, :vet_name, :clinic_name, :occurred_at, :notes, :status
    )
  end
end
