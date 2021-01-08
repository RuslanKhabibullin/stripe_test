Capybara.configure do |config|
  config.match = :prefer_exact
  config.app_host = ENV.fetch("HOST")
  config.asset_host = ENV.fetch("HOST")
end

Capybara.javascript_driver = :selenium_chrome_headless

Capybara.disable_animation = true
