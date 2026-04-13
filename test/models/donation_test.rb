require "test_helper"

class DonationTest < ActiveSupport::TestCase
  def setup
    @donation = donations(:donation_one)
  end

  test "should be valid" do
    assert @donation.valid?
  end

  test "amount is tracked and required" do
    @donation.amount = nil
    assert_not @donation.valid?
  end
  
  test "belongs to partner correctly via fixture" do
    assert_equal "PetShop XYZ", @donation.partner.name
  end
end
