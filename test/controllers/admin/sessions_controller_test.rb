require 'test_helper'

class Admin::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "successful login creates session and audit" do
    assert_difference('AuditLog.count', 1) do
      post admin_login_path, params: { email: users(:admin).email, password: "password123" }
    end
    assert_redirected_to admin_root_path
    assert_equal 'sign_in', AuditLog.last.action
  end

  test "inactive user is blocked and records fail state" do
    post admin_login_path, params: { email: users(:inactive_user).email, password: "password123" }
    assert_response :forbidden
    assert_equal 'sign_in_failure_blocked', AuditLog.last.action
  end

  test "invalid login stores audit failure" do
    post admin_login_path, params: { email: users(:admin).email, password: "wrong" }
    assert_response :unprocessable_entity
    assert_equal 'sign_in_failure_invalid', AuditLog.last.action
  end

  test "logout flushes session and audits exit route" do
    log_in_as_admin
    assert_difference('AuditLog.count', 1) do
      delete admin_logout_path
    end
    assert_redirected_to admin_login_path
    assert_equal 'sign_out', AuditLog.last.action
  end
end
