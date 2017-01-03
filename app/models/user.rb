class User < ApplicationRecord

    #Make sure the User has a username and email, and that they adhere to certain
    #criteria.

    #RegEx for a correct email address:
    #\W+\-. is for one word, plus sign, hyphen or dot
    #@ is for the @-sign
    #a-z\d\- for at least one letter, digit or hyphen
    #etc.
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :name, presence: true, length: {maximum: 52}, uniqueness: true
    validates :email, presence: true, length: {maximum: 255},
                format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}
end
