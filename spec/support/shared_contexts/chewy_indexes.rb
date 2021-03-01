# skip rule with `When` for shared contexts because it's not fit here
# rubocop:disable RSpec/ContextWording
shared_context "chewy indexes" do
  before(:each) do
    ActiveRecord::Base.connection.reset_pk_sequence! :items
    ItemsIndex.purge!
  end
end
# rubocop:enable RSpec/ContextWording
