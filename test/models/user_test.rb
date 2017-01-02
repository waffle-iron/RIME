require 'test_helper'

class UserTest < ActiveSupport::TestCase

    def setup
        @userValid = User.new(name: "Example User", email: "user@example.com")
        @userEmptyEmail = User.new(name: "Empty Email", email: "  ")
        @userEmptyName = User.new(name: "", email: "empty.email@gmail.com")
        @userRegex = User.new(name: "Ex", email: "")
        @userLength = User.new(name: "", email: "")
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
        validEmails = %w[joe.blogs@gmail.com joeblogs420@hotmail.co.uk xxJoe_Blogs420xx@my.bristol.ac.uk]

        invalidEmails.each do |invalidEmail|
            @userRegex.email = invalidEmail
            assert_not @userRegex.valid?, "#{invalidEmail.inspect} should be invalid."
        end

        validEmails.each do |validEmail|
            @userRegex.email = validEmail
            assert @userRegex.valid?, "#{validEmail.inspect} should be valid."
        end
    end

    test "field length test" do
        tooLongForUN = "01234567891011121314151617181920212223242526272829303132333435363738394041"
        tooLongForEmail = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaa@example.com"

        @userLength.name = tooLongForUN
        assert_not @userLength.valid?

        @userLength.name = "Joe_Blogs"
        @userLength.email = tooLongForEmail
        assert_not @userLength.valid?
    end
end
