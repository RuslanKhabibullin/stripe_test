VCR.configure do |c|
  c.ignore_localhost = true

  c.ignore_hosts(
    "chrome",
    "chromedriver.storage.googleapis.com"
  )

  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
  c.default_cassette_options = { record: (RUN_ON_CI ? :none : :new_episodes) }
  c.configure_rspec_metadata!
end
