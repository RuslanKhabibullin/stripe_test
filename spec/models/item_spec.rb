require "rails_helper"

describe Item, type: :model do
  subject(:item) { described_class.new(attributes_for(:item)) }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:price) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
end
