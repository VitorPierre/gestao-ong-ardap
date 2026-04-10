require "test_helper"

class Admin::FosterCaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @foster_care = foster_cares(:one)
  end

  test "should get index" do
    get admin_foster_cares_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_foster_care_url
    assert_response :success
  end

  test "should create foster_care" do
    assert_difference("FosterCare.count") do
      post admin_foster_cares_url, params: { foster_care: {} }
    end

    assert_redirected_to admin_foster_care_url(FosterCare.last)
  end

  test "should show foster_care" do
    get admin_foster_care_url(@foster_care)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_foster_care_url(@foster_care)
    assert_response :success
  end

  test "should update foster_care" do
    patch admin_foster_care_url(@foster_care), params: { foster_care: {} }
    assert_redirected_to admin_foster_care_url(@foster_care)
  end

  test "should destroy foster_care" do
    assert_difference("FosterCare.count", -1) do
      delete admin_foster_care_url(@foster_care)
    end

    assert_redirected_to admin_foster_cares_url
  end
end
