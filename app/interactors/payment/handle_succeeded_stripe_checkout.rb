module Payment
  class HandleSucceededStripeCheckout
    include ::Interactor

    delegate :stripe_event, to: :context
    delegate :id, to: :stripe_event, prefix: true

    def call
      context.fail! unless can_be_fulfilled?

      payment_session.stripe_event_id = stripe_event_id
      payment_session.pay

      # Place for heavy async workers call - where payment_session can be fulfilled
      # Since we don't have any heavy calculactions - fulfill payment_session now
      payment_session.fulfill
    end

    private

    def can_be_fulfilled?
      payment_session.present? &&
        stripe_event_id.present? &&
        payment_session.stripe_event_id != stripe_event_id
    end

    def payment_session
      @payment_session ||= ::PaymentSession.find_by(stripe_checkout_session_id: session_id)
    end

    def session_id
      stripe_event.data.object.id
    end
  end
end
