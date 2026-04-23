class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? && options[:allow_blank]

    unless cpf_valid?(value)
      record.errors.add(attribute, options[:message] || "não é um CPF válido")
    end
  end

  private

  def cpf_valid?(cpf)
    return false if cpf.nil?
    cpf = cpf.to_s.gsub(/\D/, '')

    return false if cpf.length != 11
    return false if cpf.chars.uniq.length == 1 # Rejeita 11111111111

    calculate_digit(cpf, 9) == cpf[9].to_i && calculate_digit(cpf, 10) == cpf[10].to_i
  end

  def calculate_digit(cpf, position)
    sum = 0
    weight = position + 1

    position.times do |i|
      sum += cpf[i].to_i * weight
      weight -= 1
    end

    remainder = sum % 11
    remainder < 2 ? 0 : 11 - remainder
  end
end
