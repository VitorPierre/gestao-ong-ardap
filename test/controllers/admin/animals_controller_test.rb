require 'test_helper'

class Admin::AnimalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in_as_operator
    @animal = animals(:dog_one)
  end

  test "should get index and show gracefully" do
    get admin_animals_path
    assert_response :success
    get admin_animal_path(@animal)
    assert_response :success
  end

  test "create injects native audit action properly" do
    post admin_animals_path, params: { animal: { name: "Luke", species: "dog", gender: "male" } }
    assert_redirected_to admin_animal_path(Animal.last)
    assert_equal 'create', AuditLog.last.action
  end

  test "update modifies record and tracks changes" do
    patch admin_animal_path(@animal), params: { animal: { weight: 200 } }
    assert_equal 200, @animal.reload.weight
    assert_equal 'update', AuditLog.last.action
  end

  test "destroy triggers obliteration log" do
    delete admin_animal_path(@animal)
    assert_equal 'destroy', AuditLog.last.action
  end
end
