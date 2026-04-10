class Admin::DocumentLinksController < Admin::BaseController
  def create
    @document_link = DocumentLink.new(document_link_params)
    
    if @document_link.save
      redirect_back fallback_location: admin_root_path, notice: "Documento vinculado com sucesso."
    else
      redirect_back fallback_location: admin_root_path, alert: "Erro ao vincular documento."
    end
  end

  def destroy
    @document_link = DocumentLink.find(params.expect(:id))
    @document_link.destroy
    redirect_back fallback_location: admin_root_path, notice: "Vínculo de documento removido."
  end

  private

  def document_link_params
    params.require(:document_link).permit(:document_id, :documentable_type, :documentable_id)
  end
end
