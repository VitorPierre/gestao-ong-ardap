class Admin::AnimalsController < Admin::BaseController
  before_action :set_animal, only: %i[ show edit update destroy ]

  # GET /admin/animals or /admin/animals.json
  def index
    @animals = Animal.all
  end

  # GET /admin/animals/1 or /admin/animals/1.json
  def show
  end

  # GET /admin/animals/new
  def new
    @animal = Animal.new
  end

  # GET /admin/animals/1/edit
  def edit
  end

  # POST /admin/animals or /admin/animals.json
  def create
    @animal = Animal.new(animal_params)

    respond_to do |format|
      if @animal.save
        format.html { redirect_to [:admin, @animal], notice: "Animal was successfully created." }
        format.json { render :show, status: :created, location: @animal }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/animals/1 or /admin/animals/1.json
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html { redirect_to [:admin, @animal], notice: "Animal was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @animal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/animals/1 or /admin/animals/1.json
  def destroy
    @animal.destroy!

    respond_to do |format|
      format.html { redirect_to admin_animals_path, notice: "Animal was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def animal_params
      params.fetch(:animal, {})
    end
end
