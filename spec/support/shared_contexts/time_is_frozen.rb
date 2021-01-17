# skip rule with `When` for shared contexts because it's not fit here
# rubocop:disable RSpec/ContextWording
shared_context "time is frozen" do
  let(:current_time) { Time.new(2021, 1, 17, 14, 0_0, 0_0, "+00:00").in_time_zone("UTC") }

  before(:each) { Timecop.freeze(current_time) }

  after(:each) { Timecop.return }
end
# rubocop:enable RSpec/ContextWording
