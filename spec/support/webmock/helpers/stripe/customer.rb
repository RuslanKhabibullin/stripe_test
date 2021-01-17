module WebmockHelpers
  module Stripe
    module Customer
      STRIPE_CUSTOMER_ID = "cus_1".freeze
      STRIPE_CUSTOMER_CREATE_URL = "https://api.stripe.com/v1/customers".freeze

      STRIPE_CUSTOMER_CREATE_RESPONSE_BODY = {
        id: STRIPE_CUSTOMER_ID
      }.freeze
      STRIPE_CUSTOMER_CREATE_FAILURE_RESPONSE_BODY = {
        type: "invalid_request_error",
        code: 400,
        message: "Invalid source"
      }.freeze

      def stub_stripe_customer_create
        stub_request(:post, STRIPE_CUSTOMER_CREATE_URL)
          .to_return(status: 201, body: STRIPE_CUSTOMER_CREATE_RESPONSE_BODY.to_json)
      end

      def stub_stripe_customer_failure_create
        stub_request(:post, STRIPE_CUSTOMER_CREATE_URL)
          .to_return(status: 400, body: STRIPE_CUSTOMER_CREATE_FAILURE_RESPONSE_BODY.to_json)
      end
    end
  end
end
