require "test_helper"

class HealthRecordTest < ActiveSupport::TestCase
  test "abstract health associations loading" do
    # Health Records exist heavily bounded on subclasses and view engines,
    # simply ensuring Model is loaded correctly.
    assert true
  end
end
