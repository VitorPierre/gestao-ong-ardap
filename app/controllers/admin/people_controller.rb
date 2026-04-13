class Admin::PeopleController < Admin::BaseController
  before_action :set_person, only: %i[ show edit update destroy ]

  def index
    @people = Person.all.order(:name)
  end

  def show
  end

  def new
    @person = Person.new
  end

  def edit
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to admin_people_path, notice: "Pessoa cadastrada com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @person.update(person_params)
      redirect_to admin_person_path(@person), notice: "Pessoa atualizada com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @person.destroy!
    redirect_to admin_people_path, notice: "Pessoa removida com sucesso.", status: :see_other
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :email, :phone, :cpf, :rg, :address, :city, :state, :relationship_type)
  end
end
