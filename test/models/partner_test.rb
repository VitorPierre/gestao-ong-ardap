require "test_helper"

class PartnerTest < ActiveSupport::TestCase
  def setup
    @partner = partners(:partner_one)
  end

  test "is valid" do
    assert @partner.valid?
  end

  test "associations bind to donations" do
    assert_respond_to @partner, :donations
  end
end
