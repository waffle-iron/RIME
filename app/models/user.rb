class User < ApplicationRecord
    attr_accessor :remember_token

    before_save { self.email = email.downcase }

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

    #Creates a password digest from the given string, using BCrypt.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST
                                                    : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    #Creates a login token for the user, so that they can be remembered across sessions
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token)) #for security in the DB
    end

    #Does the given token match the remember token digest?
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end
end
