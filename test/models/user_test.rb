require 'test_helper'

class UserTest < ActiveSupport::TestCase

    def setup
        @userValid = User.new(name: "Example User", email: "user@example.com")
        @userEmptyEmail = User.new(name: "Empty Email", email: "  ")
        @userEmptyName = User.new(name: "", email: "empty.email@gmail.com")
        @userRegex = User.new(name: "Ex", email: "")
    end

    test "presence test should be present" do
        assert @userValid.valid?
    end

    test "Presence test not present" do
        assert_not @userEmptyName.valid?
        assert_not @userEmptyEmail.valid?
    end

    test "email regex test" do
        invalidEmails = %w[joe.blogs@mail,com joe.blogs-at-mail.com joe.blogs@mail. @mail.com]

        invalidEmails.each do |invalidEmail|
            @userRegex.email = invalidEmail
            assert_not @userRegex.valid? "#{invalidEmail.inspect} should be invalid."
        end
    end

    test "field length test" do
        
    end
end
