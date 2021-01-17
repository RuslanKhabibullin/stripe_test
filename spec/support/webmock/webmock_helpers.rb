require_relative "helpers/stripe/customer"
require_relative "helpers/stripe/checkout"

module WebmockHelpers
  include WebmockHelpers::Stripe::Customer
  include WebmockHelpers::Stripe::Checkout
end
