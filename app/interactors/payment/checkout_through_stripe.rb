module Payment
  class CheckoutThroughStripe
    include ::Interactor

    delegate :payment_data, to: :context

    def call
      context.stripe_session = ::Stripe::Checkout::Session.create(payment_data)
    rescue ::Stripe::StripeError => e
      context.fail!(error: e.message)
    end

    def rollback
      ::Stripe::Refund.create(payment_intent: context.stripe_session.payment_intent)
    rescue ::Stripe::StripeError => e
      context.fail!(error: e.message)
    end
  end
end
