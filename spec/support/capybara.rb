CHROME_HUB_URL = ENV["HUB_URL"]

Capybara.register_driver :container_chrome_headless do |app|
  capabilities = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[no-sandbox headless disable-gpu] }
  )

  config = CHROME_HUB_URL.present? ? { browser: :remote, url: CHROME_HUB_URL } : { browser: :chrome }

  Capybara::Selenium::Driver.new(app, config.merge(desired_capabilities: capabilities))
end

Capybara.configure do |config|
  config.javascript_driver = CHROME_HUB_URL.present? ? :container_chrome_headless : :selenium_chrome_headless
  config.match = :prefer_exact
  config.disable_animation = true
  config.always_include_port = true

  if CHROME_HUB_URL.present?
    config.server_host = "0.0.0.0"
    config.server_port = 4_000
    config.app_host = "http://web:4000"
  end
end
