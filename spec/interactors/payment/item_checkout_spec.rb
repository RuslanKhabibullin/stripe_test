require "rails_helper"

describe Payment::ItemCheckout do
  describe "#organized" do
    subject(:item_checkout) { described_class.organized }

    let(:expected_interactors) do
      [
        ::Payment::CheckStripeCustomer,
        ::Payment::CreatePayment,
        ::Payment::PrepareCheckoutStripeData,
        ::Payment::CheckoutThroughStripe,
        ::Payment::UpdatePaymentAfterCheckout
      ]
    end

    it { is_expected.to eq expected_interactors }
  end
end
