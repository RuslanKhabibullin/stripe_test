module Payment
  class CheckStripeCustomer
    include ::Interactor

    delegate :user, to: :context

    def call
      context.customer_token = customer_token
    rescue ::Stripe::StripeError => e
      context.fail!(error: e.message)
    end

    private

    # Need to make sure that we save stripe data to user model despite validations
    # rubocop:disable Rails/SkipsModelValidations
    def customer_token
      return user.customer_token if user.customer_token.present?

      user.update_column(:customer_token, stripe_customer.id)
      stripe_customer.id
    end
    # rubocop:enable Rails/SkipsModelValidations

    def stripe_customer
      @stripe_customer ||= ::Stripe::Customer.create(
        email: user.email,
        description: "User No: #{user.id}",
        name: user.full_name
      )
    end
  end
end
