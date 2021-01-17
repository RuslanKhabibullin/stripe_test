module WebmockHelpers
  module Stripe
    module Checkout
      STRIPE_CHECKOUT_ID = "cs_text_1".freeze
      STRIPE_CHECKOUT_URL = "https://api.stripe.com/v1/checkout/sessions".freeze
      STRIPE_CHECKOUT_PAYMENT_INTENT_ID = "pi_1".freeze

      STRIPE_CHECKOUT_RESPONSE_BODY = {
        id: STRIPE_CHECKOUT_ID,
        object: "checkout.session",
        allow_promotion_codes: nil,
        amount_subtotal: nil,
        amount_total: 100,
        billing_address_collection: nil,
        cancel_url: "https://example.com/cancel",
        client_reference_id: nil,
        currency: "usd",
        customer: {
          id: "cus_1"
        },
        livemode: false,
        locale: nil,
        metadata: {},
        mode: "payment",
        payment_intent: STRIPE_CHECKOUT_PAYMENT_INTENT_ID,
        payment_method_types: [
          "card"
        ],
        payment_status: "unpaid",
        setup_intent: nil,
        shipping: nil,
        shipping_address_collection: nil,
        submit_type: nil,
        subscription: nil,
        success_url: "https://example.com/success",
        total_details: nil
      }.freeze

      def stub_stripe_checkout_create
        stub_request(:post, STRIPE_CHECKOUT_URL)
          .to_return(status: 201, body: STRIPE_CHECKOUT_RESPONSE_BODY.to_json)
      end
    end
  end
end
