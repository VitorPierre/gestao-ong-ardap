require "test_helper"

class FosterCareTest < ActiveSupport::TestCase
  def setup
    @foster = foster_cares(:foster_one)
  end

  test "is valid via fixture" do
    assert @foster.valid?
  end

  test "must belong to a person" do
    @foster.person = nil
    assert_not @foster.valid?
  end

  test "has start_date tracking" do
    assert_not_nil @foster.start_date
  end
end
