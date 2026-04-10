class Admin::AdoptionsController < Admin::BaseController
  before_action :set_adoption, only: %i[ show edit update destroy ]

  # GET /admin/adoptions or /admin/adoptions.json
  def index
    @adoptions = Adoption.all
  end

  # GET /admin/adoptions/1 or /admin/adoptions/1.json
  def show
  end

  # GET /admin/adoptions/new
  def new
    @adoption = Adoption.new
  end

  # GET /admin/adoptions/1/edit
  def edit
  end

  # POST /admin/adoptions or /admin/adoptions.json
  def create
    @adoption = Adoption.new(adoption_params)

    respond_to do |format|
      if @adoption.save
        format.html { redirect_to [:admin, @adoption], notice: "Adoption was successfully created." }
        format.json { render :show, status: :created, location: @adoption }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @adoption.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/adoptions/1 or /admin/adoptions/1.json
  def update
    respond_to do |format|
      if @adoption.update(adoption_params)
        format.html { redirect_to [:admin, @adoption], notice: "Adoption was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @adoption }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @adoption.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/adoptions/1 or /admin/adoptions/1.json
  def destroy
    @adoption.destroy!

    respond_to do |format|
      format.html { redirect_to admin_adoptions_path, notice: "Adoption was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adoption
      @adoption = Adoption.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def adoption_params
      params.fetch(:adoption, {})
    end
end
