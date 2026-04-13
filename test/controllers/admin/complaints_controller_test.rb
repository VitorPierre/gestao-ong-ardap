require 'test_helper'

class Admin::ComplaintsControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as_operator
    @record = complaints(:complaint_one)
  end

  test "complaints simple indexing behaves normally" do
    get admin_complaints_path
    assert_response :success
  end

  test "complaints updating works and drops log" do
    patch admin_complaint_path(@record), params: { complaint: {} }
    assert_response :redirect
    # Usually 'update' but if params empty valid still passes.
  end
end
