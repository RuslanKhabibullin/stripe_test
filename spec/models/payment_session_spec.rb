require "rails_helper"

describe PaymentSession, type: :model do
  subject(:payment_session) { described_class.new payment_session_params }

  let!(:item) { create :item }
  let!(:user) { create :user }
  let(:payment_session_params) do
    {
      item: item,
      user: user
    }
  end

  it { is_expected.to respond_to(:user) }
  it { is_expected.to respond_to(:item) }
  it { is_expected.to respond_to(:stripe_checkout_session_id) }
  it { is_expected.to respond_to(:stripe_payment_intent_id) }
  it { is_expected.to respond_to(:stripe_event_id) }

  describe "can respond to states methods" do
    %i[
      created?
      paid?
      fulfilled?
      failed?
    ].each do |state_check_method|
      it { is_expected.to respond_to(state_check_method) }
    end

    %i[
      pay
      fulfill
      payment_fail
    ].each do |state_move_method|
      it { is_expected.to respond_to(state_move_method) }
    end
  end

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:item_id) }
  it { is_expected.not_to validate_presence_of(:stripe_checkout_session_id) }
  it { is_expected.not_to validate_presence_of(:stripe_payment_intent_id) }
  it { is_expected.not_to validate_presence_of(:stripe_event_id) }

  context "when state is paid or fulfilled" do
    let(:payment_session_params) do
      {
        item: item,
        user: user,
        state: :paid
      }
    end

    it { is_expected.not_to be_valid }
    it { is_expected.to validate_presence_of(:stripe_checkout_session_id) }
    it { is_expected.to validate_presence_of(:stripe_payment_intent_id) }
    it { is_expected.to validate_presence_of(:stripe_event_id) }
  end
end
