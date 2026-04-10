require "test_helper"

class Admin::VolunteersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @volunteer = volunteers(:one)
  end

  test "should get index" do
    get admin_volunteers_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_volunteer_url
    assert_response :success
  end

  test "should create volunteer" do
    assert_difference("Volunteer.count") do
      post admin_volunteers_url, params: { volunteer: {} }
    end

    assert_redirected_to admin_volunteer_url(Volunteer.last)
  end

  test "should show volunteer" do
    get admin_volunteer_url(@volunteer)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_volunteer_url(@volunteer)
    assert_response :success
  end

  test "should update volunteer" do
    patch admin_volunteer_url(@volunteer), params: { volunteer: {} }
    assert_redirected_to admin_volunteer_url(@volunteer)
  end

  test "should destroy volunteer" do
    assert_difference("Volunteer.count", -1) do
      delete admin_volunteer_url(@volunteer)
    end

    assert_redirected_to admin_volunteers_url
  end
end
