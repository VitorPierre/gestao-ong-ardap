require "application_system_test_case"

class ViewerRestrictionsTest < ApplicationSystemTestCase
  test "viewer cannot see modification buttons" do
    visit admin_login_path
    find("input[type='email']").set(users(:viewer).email)
    find("input[type='password']").set("password123")
    find('form input[type="submit"], form button[type="submit"]').click

    visit new_admin_animal_path
    assert_text "APENAS DE LEITURA"
  end
end
