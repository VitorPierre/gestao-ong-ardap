class Admin::AdoptionsController < Admin::BaseController
  before_action :set_adoption, only: %i[ show edit update destroy ]

  def index
    @adoptions = Adoption.all.includes(:person, :animal).order(created_at: :desc)
  end

  def show
  end

  def new
    @adoption = Adoption.new
  end

  def edit
  end

  def create
    @adoption = Adoption.new(adoption_params)
    if @adoption.save
      redirect_to admin_adoptions_path, notice: "Adoção cadastrada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @adoption.update(adoption_params)
      redirect_to admin_adoption_path(@adoption), notice: "Adoção atualizada com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @adoption.destroy!
    redirect_to admin_adoptions_path, notice: "Adoção removida com sucesso.", status: :see_other
  end

  private

  def set_adoption
    @adoption = Adoption.find(params[:id])
  end

  def adoption_params
    params.require(:adoption).permit(:person_id, :animal_id, :applied_on, :status, :questionnaire_answers, :notes)
  end
end
