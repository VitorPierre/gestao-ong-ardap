ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "bcrypt"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # -- Authentication Helpers para Integration & System Tests --
    
    def log_in_as(user, password: 'password123')
      post admin_login_path, params: { email: user.email, password: password }
    end

    def log_in_as_admin
      log_in_as(users(:admin))
    end

    def log_in_as_operator
      log_in_as(users(:operator))
    end

    def log_in_as_viewer
      log_in_as(users(:viewer))
    end
  end
end
