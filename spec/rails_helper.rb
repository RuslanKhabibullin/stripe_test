require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "capybara/rspec"
require "webmock/rspec"
require "chewy/rspec"

Dir[Rails.root.join("spec", "support", "**", "*.rb")].sort.each { |f| require f }

WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: [
    "chromedriver.storage.googleapis.com",
    %r{http://chrome:4444/wd/hub}
  ]
)

# include after files require
# rubocop:disable Style/MixinUsage
include WebmockHelpers
# rubocop:enable Style/MixinUsage

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include JsonResponse
end
