require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Chablie Example", email: "chablie@example.com", username: "chablieexample", phone_number: "02038238947", password: "123456", password_confirmation: "123456")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  test "username should be present" do
    @user.username = "  "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "phone number should not be too long" do
    @user.phone_number = "1" * 12 
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "associated chables should be destroyed" do
    @user.save
    @user.chables.create!(content: "Hello World")
    assert_difference 'Chable.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    admin = users(:admin)
    areeba  = users(:areeba)
    assert_not admin.following?(areeba)
    admin.follow(areeba)
    assert admin.following?(areeba)
    assert areeba.followers.include?(admin)
    admin.unfollow(areeba)
    assert_not admin.following?(areeba)
  end

  test "feed should have the right posts" do
    admin = users(:admin)
    areeba  = users(:areeba)
    hooria = users(:hooria)
    hooria.chables.each do |post_following|
      assert admin.feed.include?(post_following)
    end
    admin.chables.each do |post_self|
      assert admin.feed.include?(post_self)
    end
    areeba.chables.each do |post_unfollowed|
      assert_not admin.feed.include?(post_unfollowed)
    end
  end
end