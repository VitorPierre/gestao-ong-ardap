module NormalizesDocuments
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_documents
  end

  private

  def normalize_documents
    if self.respond_to?(:email) && email.present?
      self.email = email.to_s.downcase.strip
    end

    if self.respond_to?(:cpf) && cpf.present?
      self.cpf = cpf.to_s.gsub(/\D/, '')
    end

    if self.respond_to?(:cnpj) && cnpj.present?
      self.cnpj = cnpj.to_s.gsub(/\D/, '')
    end

    if self.respond_to?(:rg) && rg.present?
      self.rg = rg.to_s.upcase.gsub(/[^0-9X.\-]/, '').strip
    end
    
    if self.respond_to?(:phone) && phone.present?
      # Pode manter +, (, ), - ou tirar, dependendo do que quisermos, 
      # mas o user pediu só normalizar doc e mail primariamente. 
      # Para o phone faremos strip apenas.
      self.phone = phone.to_s.strip
    end
    
    if self.respond_to?(:document_number) && document_number.present?
      # Genérico (ex: Partner ou DocumentParticipant)
      if self.respond_to?(:document_kind) && document_kind == 'cpf'
        self.document_number = document_number.to_s.gsub(/\D/, '')
      elsif self.respond_to?(:document_kind) && document_kind == 'cnpj'
        self.document_number = document_number.to_s.gsub(/\D/, '')
      else
        self.document_number = document_number.to_s.gsub(/[^0-9X.\-]/i, '').upcase.strip
      end
    end
    
    if self.respond_to?(:document) && document.present?
      # Genérico Partner onde o field chama document, limpa tudo q n for dígito ou mantém? 
      # Vamos manter apenas dígitos se a intenção for só ter CPF/CNPJ
      self.document = document.to_s.gsub(/\D/, '')
    end
  end
end
