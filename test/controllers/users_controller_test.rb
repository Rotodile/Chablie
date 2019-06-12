require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

    def setup
        @user = users(:admin)
        @other_user = users(:areeba)
    end
    
    test "should redirect edit when not logged in" do
        get edit_user_path(@user)
        assert_not flash.empty?
        assert_redirected_to login_url
    end

    test "should redirect update when not logged in" do
        patch user_path(@user), params: { user: { name: @user.name,
                                                  username: @user.username } }
        assert_not flash.empty?
        assert_redirected_to login_url
      end

      test "should redirect following when not logged in" do
        get following_user_path(@user)
        assert_redirected_to login_url
      end
    
      test "should redirect followers when not logged in" do
        get followers_user_path(@user)
        assert_redirected_to login_url
      end
end
