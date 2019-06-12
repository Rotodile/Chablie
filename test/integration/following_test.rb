require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:admin)
    @other = users(:areeba)
    log_in_as(@user)
  end

  test "should follow a user the standard way" do
    assert_difference '@user.following.count', 1 do
      post connections_path, params: { followed_id: @other.id }
    end
  end

  test "should follow a user with Ajax" do
    assert_difference '@user.following.count', 1 do
      post connections_path, xhr: true, params: { followed_id: @other.id }
    end
  end

  test "should unfollow a user the standard way" do
    @user.follow(@other)
    connection = @user.active_connections.find_by(followed_id: @other.id)
    assert_difference '@user.following.count', -1 do
      delete connection_path(connection)
    end
  end

  test "should unfollow a user with Ajax" do
    @user.follow(@other)
    connection = @user.active_connections.find_by(followed_id: @other.id)
    assert_difference '@user.following.count', -1 do
      delete connection_path(connection), xhr: true
    end
  end
end
