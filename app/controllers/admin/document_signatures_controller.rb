require 'digest'

class Admin::DocumentSignaturesController < Admin::BaseController
  before_action :set_document

  def new
    @signature = @document.build_document_signature
  end

  def create
    # Security Note: Esta implementação é uma assinatura eletrônica simples 
    # com valor administrativo interno (não substitui e-CNPJ ICP-Brasil para certidórios fiscais diretos).
    # O travamento de integridade via SHA256 torna o conteúdo do template incontestável no âmbito da ONG.
    
    @signature = @document.build_document_signature(signature_params)
    @signature.signer_ip = request.remote_ip
    @signature.signed_at = Time.current
    @signature.content_hash = Digest::SHA256.hexdigest(@document.content.to_s)
    @signature.user = defined?(current_user) ? current_user : nil

    if @signature.save
      # Lock the document and set signed flag
      @document.update_columns(status: "signed", is_locked: true, signed_at: Time.current)
      audit!('document_signed', @document, { signer_name: @signature.signer_name, ip: request.remote_ip })
      
      # Generate the definitive PDF Snapshot to active storage to freeze it forever
      pdf_html = render_to_string(
        template: "admin/documents/pdf_export",
        layout: "pdf",
        locals: { document: @document }
      )
      
      pdf_file = WickedPdf.new.pdf_from_string(pdf_html)
      
      @document.file.attach(
        io: StringIO.new(pdf_file),
        filename: "document_#{@document.id}_signed_#{Time.now.to_i}.pdf",
        content_type: "application/pdf"
      )

      redirect_to admin_document_path(@document), notice: "Documento assinado eletronicamente e travado com sucesso! Arquivo definitivo foi gerado."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_document
    @document = Document.find(params[:document_id])
    if @document.signed? || @document.is_locked?
      redirect_to admin_document_path(@document), alert: "Documento já está assinado/bloqueado."
    end
  end

  def signature_params
    params.require(:document_signature).permit(:signer_name, :accepted_terms)
  end
end
