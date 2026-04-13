class Admin::AnimalsController < Admin::BaseController
  before_action :set_animal, only: %i[ show edit update destroy ]

  def index
    @animals = Animal.all.order(:name)
  end

  def show
  end

  def new
    @animal = Animal.new
  end

  def edit
  end

  def create
    @animal = Animal.new(animal_params)
    if @animal.save
      redirect_to admin_animals_path, notice: "Animal cadastrado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @animal.update(animal_params)
      redirect_to admin_animal_path(@animal), notice: "Animal atualizado com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @animal.destroy!
    redirect_to admin_animals_path, notice: "Animal removido com sucesso.", status: :see_other
  end

  private

  def set_animal
    @animal = Animal.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:name, :species, :gender, :approximate_age, :breed, :size, :weight, :color, :neutered, :vaccinated, :dewormed, :notes, :status)
  end
end
