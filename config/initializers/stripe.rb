Stripe.api_key = ENV.fetch("STRIPE_API_KEY")
Stripe.api_version = "2020-08-27"
StripeEvent.signing_secret = ENV.fetch("STRIPE_SIGNING_SECRET")

StripeEvent.configure do |events|
  events.subscribe "checkout.session.completed" do |event|
    ::Payment::HandleSucceededStripeCheckout.call(stripe_event: event)
  end
end
