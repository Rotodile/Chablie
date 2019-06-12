require 'test_helper'

class ConnectionsControllerTest < ActionDispatch::IntegrationTest
  test "create should require logged-in user" do
    assert_no_difference 'Connection.count' do
      post connections_path
    end
    assert_redirected_to login_url
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Connection.count' do
      delete connection_path(connections(:one))
    end
    assert_redirected_to login_url
  end
end
