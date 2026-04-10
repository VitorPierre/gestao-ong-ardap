require "test_helper"

class Admin::PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
  end

  test "should get index" do
    get admin_people_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_person_url
    assert_response :success
  end

  test "should create person" do
    assert_difference("Person.count") do
      post admin_people_url, params: { person: {} }
    end

    assert_redirected_to admin_person_url(Person.last)
  end

  test "should show person" do
    get admin_person_url(@person)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_person_url(@person)
    assert_response :success
  end

  test "should update person" do
    patch admin_person_url(@person), params: { person: {} }
    assert_redirected_to admin_person_url(@person)
  end

  test "should destroy person" do
    assert_difference("Person.count", -1) do
      delete admin_person_url(@person)
    end

    assert_redirected_to admin_people_url
  end
end
