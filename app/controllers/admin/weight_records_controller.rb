class Admin::WeightRecordsController < Admin::BaseController
  before_action :set_animal, only: [:new, :create]
  before_action :set_weight_record, only: [:edit, :update, :destroy]

  def new
    @weight_record = @animal.weight_records.new(measured_at: Date.current)
  end

  def edit
    @animal = @weight_record.animal
  end

  def create
    @weight_record = @animal.weight_records.new(weight_record_params)
    if @weight_record.save
      redirect_to admin_animal_path(@animal, tab: 'weight'), notice: "Peso registrado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @weight_record.update(weight_record_params)
      redirect_to admin_animal_path(@weight_record.animal, tab: 'weight'), notice: "Peso atualizado."
    else
      @animal = @weight_record.animal
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    animal = @weight_record.animal
    @weight_record.destroy!
    redirect_to admin_animal_path(animal, tab: 'weight'), notice: "Registro de peso removido.", status: :see_other
  end

  private

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def set_weight_record
    @weight_record = WeightRecord.find(params[:id])
  end

  def weight_record_params
    params.require(:weight_record).permit(
      :weight, :measured_at, :notes
    )
  end
end
