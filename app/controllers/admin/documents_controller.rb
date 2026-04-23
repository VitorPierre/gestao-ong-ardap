class Admin::DocumentsController < Admin::BaseController
  before_action :set_document, only: %i[ show edit update destroy mark_generated cancel generate_pdf ]

  # GET /admin/documents or /admin/documents.json
  def index
    query = Document.all.order(created_at: :desc)
    
    query = query.where(category: params[:category]) if params[:category].present?
    query = query.where(document_type: params[:type]) if params[:type].present?
    query = query.where(status: params[:status]) if params[:status].present?

    @grouped_documents = query.group_by(&:category)
  end

  # GET /admin/documents/1 or /admin/documents/1.json
  def show
  end

  def mark_generated
    if @document.draft?
      @document.update(status: 'generated')
      audit!('mark_generated', @document)
      redirect_to admin_document_path(@document), notice: "Documento marcado como gerado, pronto para assinatura."
    else
      redirect_to admin_document_path(@document), alert: "Documento estruturado incorretamente."
    end
  end

  def cancel
    if @document.signed? || @document.generated? || @document.draft?
      @document.update_columns(status: 'canceled', is_locked: true)
      audit!('cancel', @document)
      redirect_to admin_document_path(@document), notice: "Documento foi cancelado com sucesso."
    end
  end

  def generate_pdf
    if @document.file.attached? && @document.signed? && !params[:force_preview]
      redirect_to rails_blob_path(@document.file, disposition: "attachment")
    else
      render pdf: "Documento_#{@document.id}",
             template: "admin/documents/pdf_export",
             layout: "pdf",
             formats: [:html]
    end
  end

  # GET /admin/documents/new
  def new
    if params[:document_type].blank?
      render :select_type
    else
      @document = Document.new(
        category: params[:category],
        document_type: params[:document_type],
        linked_id: params[:linked_id],
        linked_type: params[:linked_type]
      )
      @document.document_participants.build
    end
  end

  # GET /admin/documents/1/edit
  def edit
  end

  # POST /admin/documents or /admin/documents.json
  def create
    @document = Document.new(document_params)
    @document.creator_user = current_user

    if @document.document_type.present? && params[:document_data].present?
      begin
        html_content = render_to_string(
          partial: "admin/documents/templates/#{@document.document_type}",
          locals: { data: params[:document_data].permit!.to_h },
          formats: [:html]
        )
        @document.content = html_content
      rescue ActionView::MissingTemplate
        # fallback se não tiver template
      end
    end

    respond_to do |format|
      if @document.save
        format.html { redirect_to [:admin, @document], notice: "Documento foi criado com sucesso." }
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
        format.html { redirect_to [:admin, @document], notice: "Documento atualizado com sucesso.", status: :see_other }
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
      format.html { redirect_to admin_documents_path, notice: "Documento excluído com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(
        :title, :description, :file, :document_type, :category,
        :status, :content, :linked_type, :linked_id,
        document_participants_attributes: [
          :id, :full_name, :document_number, :document_kind,
          :phone, :email, :address, :role_in_document,
          :external_type, :notes, :_destroy
        ]
      )
    end
end
