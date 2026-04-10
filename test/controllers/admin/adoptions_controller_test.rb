require "test_helper"

class Admin::AdoptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @adoption = adoptions(:one)
  end

  test "should get index" do
    get admin_adoptions_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_adoption_url
    assert_response :success
  end

  test "should create adoption" do
    assert_difference("Adoption.count") do
      post admin_adoptions_url, params: { adoption: {} }
    end

    assert_redirected_to admin_adoption_url(Adoption.last)
  end

  test "should show adoption" do
    get admin_adoption_url(@adoption)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_adoption_url(@adoption)
    assert_response :success
  end

  test "should update adoption" do
    patch admin_adoption_url(@adoption), params: { adoption: {} }
    assert_redirected_to admin_adoption_url(@adoption)
  end

  test "should destroy adoption" do
    assert_difference("Adoption.count", -1) do
      delete admin_adoption_url(@adoption)
    end

    assert_redirected_to admin_adoptions_url
  end
end
