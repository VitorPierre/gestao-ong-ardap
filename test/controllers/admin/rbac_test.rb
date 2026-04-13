require 'test_helper'

class Admin::RbacTest < ActionDispatch::IntegrationTest
  setup do
    @animal = animals(:dog_one)
  end

  test "Admin possesses total access over Settings" do
    log_in_as_admin
    get admin_users_path
    assert_response :success
    get admin_audit_logs_path
    assert_response :success
  end

  test "Operator gets locked out of High Auth Modules" do
    log_in_as_operator
    get admin_users_path
    assert_response :redirect
    get admin_audit_logs_path
    assert_response :redirect
  end

  test "Viewer gets block listed on modifiers" do
    log_in_as_viewer
    # Can Read
    get admin_animals_path
    assert_response :success
    
    # Cannot Write / Open Forms
    get new_admin_animal_path
    assert_response :redirect

    post admin_animals_path, params: { animal: { name: "Test" } }
    assert_response :redirect
  end
end
