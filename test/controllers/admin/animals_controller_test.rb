require "test_helper"

class Admin::AnimalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @animal = animals(:one)
  end

  test "should get index" do
    get admin_animals_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_animal_url
    assert_response :success
  end

  test "should create animal" do
    assert_difference("Animal.count") do
      post admin_animals_url, params: { animal: {} }
    end

    assert_redirected_to admin_animal_url(Animal.last)
  end

  test "should show animal" do
    get admin_animal_url(@animal)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_animal_url(@animal)
    assert_response :success
  end

  test "should update animal" do
    patch admin_animal_url(@animal), params: { animal: {} }
    assert_redirected_to admin_animal_url(@animal)
  end

  test "should destroy animal" do
    assert_difference("Animal.count", -1) do
      delete admin_animal_url(@animal)
    end

    assert_redirected_to admin_animals_url
  end
end
