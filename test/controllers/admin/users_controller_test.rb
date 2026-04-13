require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as_admin
    @target = users(:operator)
  end

  test "CRUD setup logs audit properly" do
    post admin_users_path, params: { user: { name: "Zoro", email: "zoro@z.com", password: "password123", role: "operator" } }
    assert_redirected_to admin_users_path
    assert_equal 'user_create', AuditLog.last.action

    patch admin_user_path(@target), params: { user: { name: "Novo Op" } }
    assert_equal 'user_update', AuditLog.last.action
  end

  test "toggle logic triggers precise audit events" do
    patch toggle_active_admin_user_path(@target)
    assert_redirected_to admin_users_path
    assert_not @target.reload.active
    assert_equal 'user_disable', AuditLog.last.action

    patch toggle_active_admin_user_path(@target)
    assert @target.reload.active
    assert_equal 'user_enable', AuditLog.last.action
  end
end
