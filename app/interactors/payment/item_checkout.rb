module Payment
  class ItemCheckout
    include ::Interactor::Organizer

    organize CheckStripeCustomer,
             CreatePayment,
             PrepareCheckoutStripeData,
             CheckoutThroughStripe,
             UpdatePaymentAfterCheckout
  end
end
