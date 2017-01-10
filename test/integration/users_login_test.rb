require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:duder)   #gets the "duder" user from the fixtures
    end

    test "Valid Login Attempt, then Logout" do
        get login_path
        post login_path, params: {session: {email: @user.email, password: "password"}}
        assert is_logged_in?
        assert_redirected_to root_url
        follow_redirect!
        assert_template 'welcome/welcome'

        #Ensure the links have changed.
        assert_select "a[href=?]", login_path, count: 0
        assert_select "a[href=?]", logout_path

        delete logout_path  #sends DELETE HTTP request to the logout_path
        assert_not is_logged_in?
        assert_redirected_to root_url
        follow_redirect!
        assert_template 'welcome/welcome'

        #Ensure the links have changed.
        assert_select "a[href=?]", logout_path, count: 0
        assert_select "a[href=?]", login_path
    end

    test "Invalid Login Attempt" do
        get login_path
        assert_template 'sessions/new'
        post login_path, params: {session: {email: "invalid@invalid.com", password: "invalid"}}
        assert_template 'sessions/new'
        assert_not flash.empty?
        get root_path
        assert flash.empty?
    end
end
