Capybara.configure do |config|
  config.match = :prefer_exact
  config.javascript_driver = :selenium_chrome_headless
  config.disable_animation = true
  config.always_include_port = true
end
