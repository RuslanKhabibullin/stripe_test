RSpec.configure do |config|
  config.before(:suite) do
    Chewy.strategy(:bypass)
  end

  config.around(:each, chewy: :urgent) do |example|
    unless RUN_ON_CI
      Chewy.strategy(:urgent) do
        example.run
      end
    end
  end
end
