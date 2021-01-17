require "rails_helper"

describe Payment::HandleSucceededStripeCheckout do
  subject(:service) { described_class.call(stripe_event: stripe_event) }

  let(:stripe_event_id) { "event_1" }
  let(:stripe_event) do
    double "StripeEvent", id: stripe_event_id, data: stripe_data_object
  end
  let(:stripe_data_object) do
    double "StripeEventDataObject", object: stripe_session_object
  end
  let(:stripe_session_object) { double "StripeSessionObject", id: stripe_session_id }
  let(:stripe_session_id) { ::WebmockHelpers::Stripe::Checkout::STRIPE_CHECKOUT_ID }

  let(:item) { create :item }
  let(:user) { create :user }
  let!(:payment_session) do
    create(
      :payment_session,
      stripe_checkout_session_id: stripe_session_id,
      stripe_event_id: nil,
      user: user,
      item: item
    )
  end

  context "when payment exists" do
    it "returns successfull response" do
      expect(payment_session).to be_created
      expect(service).to be_success
      expect(payment_session.reload).to be_fulfilled
      expect(payment_session.stripe_event_id).to eq stripe_event_id
    end
  end

  context "when payment already handled" do
    let(:payment_session) do
      create(
        :payment_session,
        stripe_checkout_session_id: stripe_session_id,
        stripe_event_id: stripe_event_id,
        user: user,
        item: item
      )
    end

    it { expect(service).not_to be_success }
  end

  context "when payment not present" do
    let(:payment_session) { nil }

    it { expect(service).not_to be_success }
  end

  context "when payment not match event session_id" do
    let(:payment_session) do
      create(
        :payment_session,
        stripe_checkout_session_id: "another_session_id",
        stripe_event_id: nil,
        user: user,
        item: item
      )
    end

    it { expect(service).not_to be_success }
  end
end
