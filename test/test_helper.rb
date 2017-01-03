<<<<<<< HEAD
#For codecov
require 'coveralls'
Converalls.wear!('rails')
=======
require 'coveralls'
Coveralls.wear!('rails')
>>>>>>> 34edcabfd2310549c0f0f0686a7d85815e24142e

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
