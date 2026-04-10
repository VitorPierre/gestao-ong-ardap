class Admin::DocumentsController < Admin::BaseController
  before_action :set_document, only: %i[ show edit update destroy ]

  # GET /admin/documents or /admin/documents.json
  def index
    @documents = Document.all
  end

  # GET /admin/documents/1 or /admin/documents/1.json
  def show
  end

  # GET /admin/documents/new
  def new
    @document = Document.new
  end

  # GET /admin/documents/1/edit
  def edit
  end

  # POST /admin/documents or /admin/documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to [:admin, @document], notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/documents/1 or /admin/documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to [:admin, @document], notice: "Document was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/documents/1 or /admin/documents/1.json
  def destroy
    @document.destroy!

    respond_to do |format|
      format.html { redirect_to admin_documents_path, notice: "Document was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.expect(document: [ :title, :description, :file ])
    end
end
