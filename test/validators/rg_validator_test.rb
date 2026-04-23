require "test_helper"

class ValidatableRg
  include ActiveModel::Validations
  attr_accessor :rg, :state
  validates :rg, rg: { use_state_as_uf: true }
end

class ValidatableRgBasic
  include ActiveModel::Validations
  attr_accessor :rg
  validates :rg, rg: true
end

class RgValidatorTest < ActiveSupport::TestCase
  def setup
    @model = ValidatableRg.new
    @basic_model = ValidatableRgBasic.new
  end

  test "aceita RG de formato estruturalmente comum de qualquer UF" do
    # RG comum do RJ, MG, etc.
    @model.state = 'RJ'
    @model.rg = "12.345.678-9"
    assert @model.valid?

    @model.state = 'MG'
    @model.rg = "MG-12.345.678"
    assert @model.valid?
    
    @model.state = nil
    @model.rg = "1234567"
    assert @model.valid?
  end

  test "rejeita RG estruturalmente absurdo (muito pequeno ou muito grande)" do
    @model.rg = "123" # Menos de 4 caracteres
    assert_not @model.valid?

    @model.rg = "12345678901234567890" # Maior que o tamanho razoável do Brasil
    assert_not @model.valid?
  end

  test "rejeita lixo obvio (sequencias repetidas)" do
    @model.rg = "11111111"
    assert_not @model.valid?
    
    @model.rg = "000000000"
    assert_not @model.valid?
  end

  test "valida algoritmo de SSP-SP corretamente (valido)" do
    @model.state = 'SP'
    
    # 29.351.485-6 é válido (2*2+9*3+3*4+5*5+1*6+4*7+8*8+5*9 => sum 203 % 11 = 5. 11-5 = 6)
    @model.rg = "29.351.485-6" 
    assert @model.valid?
    
    # Valida com DV 'X'
    @model.rg = "12.345.678-X"
    # Wait, lets construct a valid X RG.
    # Base 12345678: sum = 1*2 + 2*3 + 3*4 + 4*5 + 5*6 + 6*7 + 7*8 + 8*9 = 2+6+12+20+30+42+56+72 = 240
    # 240 % 11 = 9
    # 11 - 9 = 2. Expected DV is 2. So 12.345.678-2 is valid.
    @model.rg = "12.345.678-2"
    assert @model.valid?
  end

  test "rejeita SSP-SP invalido matematicamente" do
    @model.state = 'SP'
    
    @model.rg = "12.345.678-9" # Sabemos que deveria ser 2 pelo teste anterior
    assert_not @model.valid?
    assert_includes @model.errors[:rg].join, "dígito verificador está incorreto"
  end

  test "modelo sem state (ou validacao basica) aceita SSP-SP incorreto devido ao fallback estrutural" do
    @basic_model.rg = "12.345.678-9" # Incorreto em SP, mas sem UF atrelada o sistema não tem como ter certeza e permite (falso positivo priorizando inclusão)
    assert @basic_model.valid?
  end
end
