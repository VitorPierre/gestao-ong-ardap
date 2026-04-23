class StrictEmailValidator < ActiveModel::EachValidator
  # Block basic disposable domains, and enforce strict format
  DISPOSABLE_DOMAINS = %w[mailinator.com yopmail.com tempmail.com guerillamail.com 10minutemail.com throwawaymail.com].freeze

  def validate_each(record, attribute, value)
    return if value.blank? && options[:allow_blank]

    unless value.to_s.match?(/\A[^@\s]+@[^@\s]+\.[^@\s]+\z/)
      record.errors.add(attribute, options[:message] || "tem um formato inválido")
      return
    end

    domain = value.to_s.split('@').last&.downcase
    if DISPOSABLE_DOMAINS.include?(domain)
      record.errors.add(attribute, "pertence a um provedor de e-mails descartáveis, não aceito.")
    end
  end
end
