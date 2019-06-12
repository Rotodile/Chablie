require 'test_helper'

class ChableTest < ActiveSupport::TestCase

  def setup
    @user = users(:admin)
    @chable = @user.chables.build(content: "Hello World")
  end

  test "should be valid" do
    assert @chable.valid?
  end

  test "user id should be present" do
    @chable.user_id = nil
    assert_not @chable.valid?
  end

  test "content should be present" do
    @chable.content = "  "
    assert_not @chable.valid?
  end

  test "content should be at most 140 characters" do
    @chable.content = "a" * 141
    assert_not @chable.valid?
  end

  test "order should be most recent first" do
    assert_equal chables(:most_recent), Chable.first
  end
end
