class CnpjValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? && options[:allow_blank]

    unless cnpj_valid?(value)
      record.errors.add(attribute, options[:message] || "não é um CNPJ válido")
    end
  end

  private

  def cnpj_valid?(cnpj)
    return false if cnpj.nil?
    cnpj = cnpj.to_s.gsub(/\D/, '')

    return false if cnpj.length != 14
    return false if cnpj.chars.uniq.length == 1

    calculate_digit(cnpj, 12) == cnpj[12].to_i && calculate_digit(cnpj, 13) == cnpj[13].to_i
  end

  def calculate_digit(cnpj, position)
    weights = position == 12 ? [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2] : [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    sum = 0

    position.times do |i|
      sum += cnpj[i].to_i * weights[i]
    end

    remainder = sum % 11
    remainder < 2 ? 0 : 11 - remainder
  end
end
