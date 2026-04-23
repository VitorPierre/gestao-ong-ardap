require "test_helper"

class ValidatableCpf
  include ActiveModel::Validations
  attr_accessor :cpf
  validates :cpf, cpf: true
end

class CpfValidatorTest < ActiveSupport::TestCase
  def setup
    @model = ValidatableCpf.new
  end

  test "aceita CPF valido sem mascara" do
    @model.cpf = "61909893049" # Gerado aleatório válido
    assert @model.valid?
  end

  test "aceita CPF valido com mascara" do
    @model.cpf = "619.098.930-49"
    assert @model.valid?
  end

  test "rejeita CPF com digito verificador incorreto" do
    @model.cpf = "61909893048"
    assert_not @model.valid?
    assert_includes @model.errors[:cpf], "não é um CPF válido"
  end

  test "rejeita CPF com tamanho menor que 11" do
    @model.cpf = "1234567890"
    assert_not @model.valid?
  end

  test "rejeita CPF com tamanho maior que 11" do
    @model.cpf = "123456789012"
    assert_not @model.valid?
  end

  test "rejeita CPF com sequencias repetidas" do
    ["00000000000", "11111111111", "99999999999"].each do |invalid_cpf|
      @model.cpf = invalid_cpf
      assert_not @model.valid?, "#{invalid_cpf} deveria ser invalido"
    end
  end

  test "rejeita nil e blank corretamente se nao houver allow_blank" do
    @model.cpf = nil
    assert_not @model.valid?
    
    @model.cpf = ""
    assert_not @model.valid?
  end
end
