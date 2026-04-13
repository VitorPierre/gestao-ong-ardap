require "test_helper"

class VolunteerTest < ActiveSupport::TestCase
  def setup
    @volunteer = volunteers(:volunteer_one)
  end

  test "is valid with person attached" do
    assert @volunteer.valid?
  end
end
