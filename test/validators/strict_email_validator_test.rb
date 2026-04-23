require "test_helper"
require "resolv"

class ValidatableEmail
  include ActiveModel::Validations
  attr_accessor :email
  validates :email, strict_email: true
end

class ValidatableEmailWithMxTest
  include ActiveModel::Validations
  attr_accessor :email
  validates :email, strict_email: { force_mx_test: true }
end

class StrictEmailValidatorTest < ActiveSupport::TestCase
  def setup
    @model = ValidatableEmail.new
  end

  test "aceita email com formato valido" do
    @model.email = "usuario.teste@gmail.com"
    assert @model.valid?
  end

  test "rejeita email com formato invalido" do
    @model.email = "usuario.teste@com"
    assert_not @model.valid?
    assert_includes @model.errors[:email].join, "formato inválido"
  end

  test "rejeita email com espacos" do
    @model.email = "usuario teste@gmail.com"
    assert_not @model.valid?
    assert_includes @model.errors[:email].join, "formato inválido"
  end

  test "rejeita dominio descartavel conhecido" do
    @model.email = "qualquercoisa@mailinator.com"
    assert_not @model.valid?
    assert_includes @model.errors[:email].join, "descartáveis"
  end

  test "rejeita dominio sem registros MX (forçando teste DNS)" do
    model_mx = ValidatableEmailWithMxTest.new
    
    # Domínio inexistente real que certamente falhará a busca de MX
    model_mx.email = "teste@dominio-invalido-inexistente-123999.com.br"
    assert_not model_mx.valid?
    assert_includes model_mx.errors[:email].join, "sem registros MX"
    
    # Domínio real que existe, testando o fluxo positivo (gmail.com sempre terá MX)
    model_mx.email = "teste@gmail.com"
    assert model_mx.valid?
  end
end
