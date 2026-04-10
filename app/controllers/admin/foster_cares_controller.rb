class Admin::FosterCaresController < Admin::BaseController
  before_action :set_foster_care, only: %i[ show edit update destroy ]

  # GET /admin/foster_cares or /admin/foster_cares.json
  def index
    @foster_cares = FosterCare.all
  end

  # GET /admin/foster_cares/1 or /admin/foster_cares/1.json
  def show
  end

  # GET /admin/foster_cares/new
  def new
    @foster_care = FosterCare.new
  end

  # GET /admin/foster_cares/1/edit
  def edit
  end

  # POST /admin/foster_cares or /admin/foster_cares.json
  def create
    @foster_care = FosterCare.new(foster_care_params)

    respond_to do |format|
      if @foster_care.save
        format.html { redirect_to [:admin, @foster_care], notice: "Foster care was successfully created." }
        format.json { render :show, status: :created, location: @foster_care }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @foster_care.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/foster_cares/1 or /admin/foster_cares/1.json
  def update
    respond_to do |format|
      if @foster_care.update(foster_care_params)
        format.html { redirect_to [:admin, @foster_care], notice: "Foster care was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @foster_care }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @foster_care.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/foster_cares/1 or /admin/foster_cares/1.json
  def destroy
    @foster_care.destroy!

    respond_to do |format|
      format.html { redirect_to admin_foster_cares_path, notice: "Foster care was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foster_care
      @foster_care = FosterCare.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def foster_care_params
      params.fetch(:foster_care, {})
    end
end
