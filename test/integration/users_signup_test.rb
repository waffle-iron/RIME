require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
    def setup
        ActionMailer::Base.deliveries.clear
    end

    test "Invalid Signup Form" do
        get signup_path #grab the signup page

        #This checks that there is no difference in the parameter between the start
        #and end of the loop (i.e. in this case makes sure the user is not added).
        assert_no_difference 'User.count' do
            post users_path, params: {user: {name: "",
                                             email: "user@invalid",
                                             password: "short",
                                             password_confirmation: "other"}}
        end

        assert_template "users/new" #make sure the form reloads.
    end

    test "Valid Signup Form" do
        get signup_path

        assert_difference 'User.count', 1 do
            post users_path, params: {user: {name: "test",
                                             email: "test@test.com",
                                             password: "password",
                                             password_confirmation:"password"}}
        end

        assert_equal 1, ActionMailer::Base.deliveries.size
        user = assigns(:user)
        assert_not user.activated?

        # Try to log in before activation.
        log_in_as(user)
        assert_not is_logged_in?

        # Invalid activation token
        get edit_account_activation_path("invalid token", email: user.email)
        assert_not is_logged_in?

        # Valid token, wrong email
        get edit_account_activation_path(user.activation_token, email: 'wrong')
        assert_not is_logged_in?

        # Valid activation token
        get edit_account_activation_path(user.activation_token, email: user.email)
        assert user.reload.activated?

        follow_redirect!

        assert_template 'welcome/welcome'
        assert is_logged_in?

    end
end
