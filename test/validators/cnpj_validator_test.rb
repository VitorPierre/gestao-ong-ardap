require "test_helper"

class ValidatableCnpj
  include ActiveModel::Validations
  attr_accessor :cnpj
  validates :cnpj, cnpj: true
end

class CnpjValidatorTest < ActiveSupport::TestCase
  def setup
    @model = ValidatableCnpj.new
  end

  test "aceita CNPJ valido sem mascara" do
    @model.cnpj = "86774653000185" # Gerado aleatório válido
    assert @model.valid?
  end

  test "aceita CNPJ valido com mascara" do
    @model.cnpj = "86.774.653/0001-85"
    assert @model.valid?
  end

  test "rejeita CNPJ com digito verificador incorreto" do
    @model.cnpj = "86774653000180"
    assert_not @model.valid?
    assert_includes @model.errors[:cnpj], "não é um CNPJ válido"
  end

  test "rejeita CNPJ com tamanho menor que 14" do
    @model.cnpj = "8677465300018"
    assert_not @model.valid?
  end

  test "rejeita CNPJ com tamanho maior que 14" do
    @model.cnpj = "867746530001850"
    assert_not @model.valid?
  end

  test "rejeita CNPJ com sequencias repetidas" do
    ["00000000000000", "11111111111111", "99999999999999"].each do |invalid_cnpj|
      @model.cnpj = invalid_cnpj
      assert_not @model.valid?, "#{invalid_cnpj} deveria ser invalido"
    end
  end
end
