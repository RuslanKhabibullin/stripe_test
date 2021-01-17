require "rails_helper"

describe Payment::PrepareCheckoutStripeData do
  subject(:service) do
    described_class.call(user: user, item: item, customer_token: customer_token)
  end

  let!(:item) { create :item, price: 1.00, title: "Item" }
  let!(:user) { create :user }
  let(:customer_token) { ::WebmockHelpers::Stripe::Customer::STRIPE_CUSTOMER_ID }
  let(:url_helpers) { ::Rails.application.routes.url_helpers }
  let(:url_options) { ::Rails.application.config.action_mailer.default_url_options }
  let(:expected_data) do
    {
      payment_method_types: ["card"],
      mode: "payment",
      customer: customer_token,
      success_url: url_helpers.item_payment_success_url(url_options.merge(item_id: item.id)),
      cancel_url: url_helpers.item_url(url_options.merge(id: item.id)),
      line_items: [
        {
          price_data: {
            currency: "usd",
            unit_amount: 100,
            product_data: {
              name: "Item",
              description: "Item No: #{item.id}"
            }
          },
          quantity: 1
        }
      ],
      metadata: {
        purchase_time: "17-01-2021 14:00 (UTC)"
      }
    }
  end

  include_context "time is frozen"

  it { expect(service.payment_data).to eq expected_data }
end
