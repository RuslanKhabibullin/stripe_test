require "rails_helper"

describe Payment::UpdatePaymentAfterCheckout do
  subject(:service) do
    described_class.call(stripe_session: stripe_session, payment: payment)
  end

  # Stripe gem generate class from Stripe response
  let(:stripe_session) { double("StripeSessionObject") }
  let!(:payment) do
    create(
      :payment_session,
      item: item,
      user: user,
      stripe_checkout_session_id: nil,
      stripe_payment_intent_id: nil,
      stripe_event_id: nil
    )
  end
  let(:item) { create :item }
  let(:user) { create :user }
  let(:session_id) { ::WebmockHelpers::Stripe::Checkout::STRIPE_CHECKOUT_ID }
  let(:payment_intent_id) { ::WebmockHelpers::Stripe::Checkout::STRIPE_CHECKOUT_PAYMENT_INTENT_ID }

  before(:each) do
    allow(stripe_session).to receive(:id).and_return(session_id)
    allow(stripe_session).to receive(:payment_intent).and_return(payment_intent_id)
  end

  context "when entities valid" do
    it "returns success" do
      %i[
        stripe_checkout_session_id
        stripe_payment_intent_id
      ].each do |stripe_payment_attribute|
        expect(payment.send(stripe_payment_attribute)).to be_falsey
      end

      expect(service).to be_success
      expect(payment.reload.stripe_checkout_session_id).to eq session_id
      expect(payment.stripe_payment_intent_id).to eq payment_intent_id
    end
  end

  context "when entity invalid" do
    let!(:payment) { build(:payment_session, item: nil, user: user) }

    it "returns faulure" do
      expect(service).not_to be_success
      expect(service.error).to eq "Item must exist. Item can't be blank"
    end
  end
end
