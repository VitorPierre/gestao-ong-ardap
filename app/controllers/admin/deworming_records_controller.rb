class Admin::DewormingRecordsController < Admin::BaseController
  before_action :set_animal, only: [:new, :create]
  before_action :set_deworming_record, only: [:edit, :update, :destroy]

  def new
    @deworming_record = @animal.deworming_records.new(administered_at: Date.current)
  end

  def edit
    @animal = @deworming_record.animal
  end

  def create
    @deworming_record = @animal.deworming_records.new(deworming_record_params)
    if @deworming_record.save
      redirect_to admin_animal_path(@animal, tab: 'deworming'), notice: "Vermífugo salvo com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @deworming_record.update(deworming_record_params)
      redirect_to admin_animal_path(@deworming_record.animal, tab: 'deworming'), notice: "Vermífugo atualizado."
    else
      @animal = @deworming_record.animal
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    animal = @deworming_record.animal
    @deworming_record.destroy!
    redirect_to admin_animal_path(animal, tab: 'deworming'), notice: "Registro removido.", status: :see_other
  end

  private

  def set_animal
    @animal = Animal.find(params[:animal_id])
  end

  def set_deworming_record
    @deworming_record = DewormingRecord.find(params[:id])
  end

  def deworming_record_params
    params.require(:deworming_record).permit(
      :product_name, :administered_at, :next_due_at, :notes
    )
  end
end
