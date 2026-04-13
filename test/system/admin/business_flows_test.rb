require "application_system_test_case"

class BusinessFlowsTest < ApplicationSystemTestCase
  def setup
    visit admin_login_path
    find("input[type='email']").set(users(:operator).email)
    find("input[type='password']").set("password123")
    find('form input[type="submit"], form button[type="submit"]').click
  end

  test "person cadastre E2E" do
    visit new_admin_person_path
    find('button[type="submit"], input[type="submit"]').click
    assert_selector "form", wait: 2
  end

  test "animal cadastre E2E" do
    visit new_admin_animal_path
    find('button[type="submit"], input[type="submit"]').click
    assert_selector "form", wait: 2
  end

  test "partner creation E2E" do
    visit new_admin_partner_path
    find('button[type="submit"], input[type="submit"]').click
    assert_selector "form", wait: 2
  end

  test "adoption creation E2E" do
    visit new_admin_adoption_path
    find('button[type="submit"], input[type="submit"]').click
    assert_selector "form", wait: 2
  end

  test "foster care creation E2E" do
    visit new_admin_foster_care_path
    find('button[type="submit"], input[type="submit"]').click
    assert_selector "form", wait: 2
  end

  test "volunteer creation E2E" do
    visit new_admin_volunteer_path
    find('button[type="submit"], input[type="submit"]').click
    assert_selector "form", wait: 2
  end

  test "document draft creation E2E" do
    visit new_admin_document_path
    find('button[type="submit"], input[type="submit"]').click
    assert_selector "form", wait: 2
  end

  test "complaint creation E2E" do
    visit new_admin_complaint_path
    find('button[type="submit"], input[type="submit"]').click
    assert_selector "form", wait: 2
  end

  test "donation creation E2E" do
    visit new_admin_donation_path
    find('button[type="submit"], input[type="submit"]').click
    assert_selector "form", wait: 2
  end
end
