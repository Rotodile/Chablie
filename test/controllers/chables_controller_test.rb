require 'test_helper'

class ChablesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @chable = chables(:hello)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Chable.count' do
      post chables_path, params: { chable: { content: "Hello World" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Chable.count' do
      delete chable_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong chable" do
    log_in_as(users(:admin))
    chable = chables(:hello)
    assert_no_difference 'Chable.count' do
      delete chable_path(chable)
    end
    assert_redirected_to root_url
  end
end
