class Admin::VolunteersController < Admin::BaseController
  before_action :set_volunteer, only: %i[ show edit update destroy ]

  # GET /admin/volunteers or /admin/volunteers.json
  def index
    @volunteers = Volunteer.all
  end

  # GET /admin/volunteers/1 or /admin/volunteers/1.json
  def show
  end

  # GET /admin/volunteers/new
  def new
    @volunteer = Volunteer.new
  end

  # GET /admin/volunteers/1/edit
  def edit
  end

  # POST /admin/volunteers or /admin/volunteers.json
  def create
    @volunteer = Volunteer.new(volunteer_params)

    respond_to do |format|
      if @volunteer.save
        format.html { redirect_to [:admin, @volunteer], notice: "Volunteer was successfully created." }
        format.json { render :show, status: :created, location: @volunteer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/volunteers/1 or /admin/volunteers/1.json
  def update
    respond_to do |format|
      if @volunteer.update(volunteer_params)
        format.html { redirect_to [:admin, @volunteer], notice: "Volunteer was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @volunteer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @volunteer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/volunteers/1 or /admin/volunteers/1.json
  def destroy
    @volunteer.destroy!

    respond_to do |format|
      format.html { redirect_to admin_volunteers_path, notice: "Volunteer was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_volunteer
      @volunteer = Volunteer.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def volunteer_params
      params.fetch(:volunteer, {})
    end
end
