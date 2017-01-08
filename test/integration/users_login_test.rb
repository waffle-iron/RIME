require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
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
