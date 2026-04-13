class Admin::MedicationRecordsController < Admin::BaseController
  before_action :set_animal, only: [:new, :create]
  before_action :set_medication_record, only: [:edit, :update, :destroy]

  def new
    @medication_record = @animal.medication_records.new(start_date: Date.current)
  end

  def edit
    @animal = @medication_record.animal
  end

  def create
    @medication_record = @animal.medication_records.new(medication_record_params)
    if @medication_record.save
      redirect_to admin_animal_path(@animal, tab: 'medication'), notice: "Medicamento salvo."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @medication_record.update(medication_record_params)
      redirect_to admin_animal_path(@medication_record.animal, tab: 'medication'), notice: "Medicamento atualizado."
    else
      @animal = @medication_record.animal
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    animal = @medication_record.animal
    @medication_record.destroy!
    redirect_to admin_animal_path(animal, tab: 'medication'), notice: "Registro removido.", status: :see_other
  end

  private

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def set_medication_record
    @medication_record = MedicationRecord.find(params[:id])
  end

  def medication_record_params
    params.require(:medication_record).permit(
      :medication_name, :dosage, :frequency, :start_date, :end_date, :status, :notes
    )
  end
end
