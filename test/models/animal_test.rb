require "test_helper"

class AnimalTest < ActiveSupport::TestCase
  def setup
    @animal = animals(:dog_one)
  end

  test "should be valid with initial fixture" do
    assert @animal.valid?
  end

  test "should require name and basic characteristics" do
    @animal.name = nil
    assert_not @animal.valid?, "Animal sem nome deve ser barrado"

    @animal.name = "Rex"
    @animal.species = nil
    assert_not @animal.valid?, "Animal precisa de espécie"
  end

  test "enums behave correctly" do
    assert @animal.dog?
    assert @animal.male?
    assert @animal.available?
  end
  
  test "associations testing" do
    assert_respond_to @animal, :adoptions
    assert_respond_to @animal, :foster_cares
    assert_respond_to @animal, :documents
    assert_respond_to @animal, :health_records
  end
end
