require "rails_helper"

describe Payment::CheckoutThroughStripe do
  subject(:checkout) { described_class.call(payment_data: payment_data) }

  let(:payment_data) do
    {
      payment_method_types: ["card"],
      mode: "payment",
      customer: "cus_1",
      success_url: "http://localhost:5000/items/121/payments/success",
      cancel_url: "http://localhost:5000/items/121",
      line_items: [
        {
          price_data: {
            currency: "usd",
            unit_amount: 100,
            product_data: {
              name: "Item",
              description: "Item No: 1"
            }
          },
          quantity: 1
        }
      ],
      metadata: {
        purchase_time: "16-01-2021 21:00 (UTC)"
      }
    }
  end

  context "when creation is success" do
    before(:each) { stub_stripe_checkout_create }

    it "respond with success" do
      expect(checkout).to be_success
    end
  end

  context "when stripe responds with failure" do
    before(:each) do
      allow(::Stripe::Checkout::Session)
        .to receive(:create).and_raise(::Stripe::StripeError.new("error"))
    end

    it "responds with failure" do
      expect(checkout).not_to be_success
      expect(checkout.error).to eq "error"
    end
  end
end
