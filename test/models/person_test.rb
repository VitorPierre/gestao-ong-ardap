require "test_helper"

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = people(:person_one)
  end

  test "should be valid" do
    assert @person.valid?
  end

  test "name is required" do
    @person.name = nil
    assert_not @person.valid?, "O nome deve ser obrigatorio para pessoas e agentes do sistema"
  end

  test "associations bind correctly" do
    assert_respond_to @person, :adoptions
    assert_respond_to @person, :foster_cares
    assert_respond_to @person, :volunteer
  end
end
