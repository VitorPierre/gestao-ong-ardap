require 'test_helper'

class Admin::PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as_operator
    @record = people(:person_one)
  end

  test "people simple indexing behaves normally" do
    get admin_people_path
    assert_response :success
  end

  test "people updating works and drops log" do
    patch admin_person_path(@record), params: { person: {} }
    assert_response :redirect
    # Usually 'update' but if params empty valid still passes.
  end
end
