require "application_system_test_case"

class AuthAndDashboardTest < ApplicationSystemTestCase
  test "login and access dashboard" do
    visit admin_login_path
    find("input[type='email']").set(users(:admin).email)
    find("input[type='password']").set("password123")
    find('form input[type="submit"], form button[type="submit"]').click
    
    assert_text "Dashboard"
    assert_selector "nav" # Navegador estático lateral
  end
end
