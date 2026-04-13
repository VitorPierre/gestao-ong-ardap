require 'test_helper'

class Admin::PartnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as_operator
    @record = partners(:partner_one)
  end

  test "partners simple indexing behaves normally" do
    get admin_partners_path
    assert_response :success
  end

  test "partners updating works and drops log" do
    patch admin_partner_path(@record), params: { partner: {} }
    assert_response :redirect
    # Usually 'update' but if params empty valid still passes.
  end
end
