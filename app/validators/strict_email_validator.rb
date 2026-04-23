require 'resolv'

class StrictEmailValidator < ActiveModel::EachValidator
  # Formato + validação de MX melhora consideravelmente a qualidade da base de dados,
  # mas é importante notar que SOMENTE o envio de um e-mail de confirmação (double opt-in)
  # garante de fato a existência e propriedade real da caixa postal.
  
  # Block basic disposable domains, and enforce strict format
  DISPOSABLE_DOMAINS = %w[
    mailinator.com yopmail.com tempmail.com guerillamail.com
    10minutemail.com throwawaymail.com dropmail.me
  ].freeze

  def validate_each(record, attribute, value)
    return if value.blank? && options[:allow_blank]

    email = value.to_s.strip
    
    # 1. Validação de formato (rejeita espaços e exige formato x@y.z)
    unless email.match?(/\A[^@\s]+@[^@\s]+\.[^@\s]+\z/)
      record.errors.add(attribute, options[:message] || "tem um formato inválido")
      return
    end

    domain = email.split('@').last.downcase

    # 2. Bloqueio de e-mails descartáveis conhecidos
    if DISPOSABLE_DOMAINS.include?(domain)
      record.errors.add(attribute, "pertence a um provedor de e-mails descartáveis, não aceito.")
      return
    end

    # 3. Validação de MX (capacidade real de recebimento)
    # Ignoramos a validação de MX em ambiente de testes para não deixar a suíte lenta ou dependente de internet
    unless Rails.env.test? || mx_records_exist?(domain)
      record.errors.add(attribute, "possui um domínio que não pode receber e-mails (sem registros MX).")
    end
  end

  private

  def mx_records_exist?(domain)
    begin
      mx_records = Resolv::DNS.new.getresources(domain, Resolv::DNS::Resource::IN::MX)
      mx_records.any?
    rescue Resolv::ResolvError, Resolv::ResolvTimeout
      false
    end
  end
end
