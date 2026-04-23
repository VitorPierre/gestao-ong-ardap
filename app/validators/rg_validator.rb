class RgValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank? && options[:allow_blank]

    # Tentamos extrair a UF se houver um campo para ela
    uf = nil
    uf_field = options[:uf_field] || :rg_uf
    if record.respond_to?(uf_field)
      uf = record.public_send(uf_field)
    elsif record.respond_to?(:state)
      # Fallback genérico para a UF do endereço se for aplicável e especificado
      uf = record.state if options[:use_state_as_uf]
    end

    unless rg_valid?(value, uf)
      record.errors.add(attribute, options[:message] || "não é um formato de RG válido ou o dígito verificador está incorreto")
    end
  end

  private

  def rg_valid?(rg, uf = nil)
    return false if rg.blank?
    
    clean_rg = rg.to_s.upcase.gsub(/[^0-9X]/, '')
    
    # RGs no Brasil costumam ter entre 4 a 14 caracteres (alguns estados antigos têm poucos, novos e DNI podem ter mais)
    return false if clean_rg.length < 4 || clean_rg.length > 14
    
    # Impede lixo óbvio de números repetidos longos
    return false if clean_rg.match?(/^(\d)\1{6,}$/)

    # Aplica validação matemática apenas para SSP-SP (9 dígitos com dígito verificador)
    if uf.to_s.upcase == 'SP' && clean_rg.length == 9
      return valid_sp_rg?(clean_rg)
    end
    
    # Para outros estados ou tamanhos não mapeados, consideramos válido por falta de algoritmo universal
    true
  end

  def valid_sp_rg?(rg)
    # SP RG Algoritmo:
    # 8 dígitos base + 1 dígito verificador (que pode ser X)
    # Multiplicadores da base: 2, 3, 4, 5, 6, 7, 8, 9
    
    base = rg[0..7]
    dv = rg[8]
    dv_int = dv == 'X' ? 10 : dv.to_i
    
    sum = 0
    multipliers = [2, 3, 4, 5, 6, 7, 8, 9]
    
    base.chars.each_with_index do |char, index|
      sum += char.to_i * multipliers[index]
    end
    
    # A regra em SP diz que a soma total (base + dv*100) deve ser múltiplo de 11.
    # Outra forma equivalente é: DV = 11 - (soma % 11)
    remainder = sum % 11
    expected_dv = 11 - remainder
    expected_dv = 0 if expected_dv == 11 || expected_dv == 10 && dv_int != 10
    
    dv_int == expected_dv || (expected_dv == 10 && dv == 'X') || (remainder == 0 && dv == '0')
  end
end
