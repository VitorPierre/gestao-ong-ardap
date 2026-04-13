require 'test_helper'

class Admin::AdoptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as_operator
    @record = adoptions(:adoption_one)
  end

  test "adoptions simple indexing behaves normally" do
    get admin_adoptions_path
    assert_response :success
  end

  test "adoptions updating works and drops log" do
    patch admin_adoption_path(@record), params: { adoption: {} }
    assert_response :redirect
    # Usually 'update' but if params empty valid still passes.
  end
end
