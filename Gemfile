source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.6"

gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "rails", "~> 6.0.0"
gem "sass-rails", "~> 5.0.0", ">= 5.0.6"
gem "webpacker", "~> 4.0"

gem "autoprefixer-rails"
gem "foundation-rails"
gem "meta-tags"
gem "simple_form"
gem "slim"

gem "bootsnap", ">= 1.4.2", require: false
gem "decent_decoration"
gem "decent_exposure"
gem "devise"
gem "draper"
gem "pundit"
gem "responders"
gem "seedbank"

group :development, :test do
  gem "awesome_print"
  gem "brakeman", require: false
  gem "bullet"
  gem "bundler-audit", require: false
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "scss_lint", require: false
  gem "slim_lint", require: false
end

group :development do
  gem "foreman", require: false
  gem "letter_opener"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "slim-rails"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "database_cleaner"
  gem "formulaic"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "webdrivers"
end
