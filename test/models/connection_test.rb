require 'test_helper'

class ConnectionTest < ActiveSupport::TestCase
  def setup
    @connection = Connection.new(follower_id: users(:admin).id, followed_id: users(:areeba).id)
  end

  test "should be valid" do
    assert @connection.valid?
  end

  test "should require a follower_id" do
    @connection.follower_id = nil
    assert_not @connection.valid?
  end

  test "should require a followed_id" do
    @connection.followed_id = nil
    assert_not @connection.valid?
  end
end
