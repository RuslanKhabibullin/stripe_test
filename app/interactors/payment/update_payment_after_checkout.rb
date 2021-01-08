module Payment
  class UpdatePaymentAfterCheckout
    include ::Interactor

    delegate :stripe_session, :payment, to: :context

    def call
      payment.update(payment_data)
      raise_payment_error if payment.invalid?
    end

    def rollback
      payment.payment_fail
    end

    private

    def payment_data
      {
        stripe_checkout_session_id: stripe_session.id,
        stripe_payment_intent_id: stripe_session.payment_intent
      }
    end

    def raise_payment_error
      context.fail!(error: payment.errors.full_messages.join(". "))
    end
  end
end
