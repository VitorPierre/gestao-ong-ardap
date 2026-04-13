class Admin::VaccinationRecordsController < Admin::BaseController
  before_action :set_animal, only: [:new, :create]
  before_action :set_vaccination_record, only: [:edit, :update, :destroy]

  def new
    @vaccination_record = @animal.vaccination_records.new(administered_at: Date.current)
  end

  def edit
    @animal = @vaccination_record.animal
  end

  def create
    @vaccination_record = @animal.vaccination_records.new(vaccination_record_params)
    if @vaccination_record.save
      redirect_to admin_animal_path(@animal, tab: 'vaccines'), notice: "Vacina salva com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @vaccination_record.update(vaccination_record_params)
      redirect_to admin_animal_path(@vaccination_record.animal, tab: 'vaccines'), notice: "Vacina atualizada."
    else
      @animal = @vaccination_record.animal
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    animal = @vaccination_record.animal
    @vaccination_record.destroy!
    redirect_to admin_animal_path(animal, tab: 'vaccines'), notice: "Registro removido.", status: :see_other
  end

  private

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def set_vaccination_record
    @vaccination_record = VaccinationRecord.find(params[:id])
  end

  def vaccination_record_params
    params.require(:vaccination_record).permit(
      :vaccine_name, :batch_number, :administered_at, :next_due_at, :vet_name, :notes
    )
  end
end
