class RgValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? && options[:allow_blank]

    unless rg_valid?(value)
      record.errors.add(attribute, options[:message] || "não é um formato de RG aceito")
    end
  end

  private

  def rg_valid?(rg)
    return false if rg.nil?
    
    # Strip spaces and keep only numbers, dots, dashes, and X
    clean_rg = rg.to_s.upcase.gsub(/[^0-9X.\-]/, '')
    
    return false if clean_rg.length < 4 || clean_rg.length > 20
    return false if clean_rg.gsub(/[^0-9X]/, '').length < 4

    true
  end
end
