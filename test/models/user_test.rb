require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:operator)
  end

  test "should be valid with normal attributes" do
    assert @user.valid?
  end

  test "email should be present and unique" do
    @user.email = "   "
    assert_not @user.valid?, "Expected user to be invalid without email"

    @user.email = "valid@ardap.org"
    duplicate_user = @user.dup
    @user.save!
    assert_not duplicate_user.valid?, "Expected uniqueness on email"
  end

  test "role assignment" do
    assert @user.operator?
    @user.role = :admin
    assert @user.admin?
    assert_not @user.viewer?
  end

  test "active status tracking" do
    assert @user.active?, "User should be active by default"
    @user.active = false
    assert_not @user.active?, "Active flag should be updated"
  end
end
