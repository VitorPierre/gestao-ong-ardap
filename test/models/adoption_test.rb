require "test_helper"

class AdoptionTest < ActiveSupport::TestCase
  def setup
    @adoption = adoptions(:adoption_one)
  end

  test "should be valid with fixture loaded" do
    assert @adoption.valid?
  end

  test "must belong to both an animal and a person" do
    @adoption.animal = nil
    assert_not @adoption.valid?, "Adoption requires a registered animal"

    @adoption.animal = animals(:cat_one)
    @adoption.person = nil
    assert_not @adoption.valid?, "Adoption requires an adopter (person)"
  end

  test "enum rules" do
    assert @adoption.approved?
  end
end
