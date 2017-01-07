require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
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
end
