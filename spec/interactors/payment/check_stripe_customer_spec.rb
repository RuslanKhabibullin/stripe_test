require "rails_helper"

describe Payment::CheckStripeCustomer do
  subject(:stripe_customer_check) { described_class.call(user: user) }

  let!(:user) { create :user }

  context "when customer_token already present" do
    let!(:user) { create :user, customer_token: "token" }

    it { is_expected.to be_success }
  end

  context "when customer_token not present" do
    let!(:user) { create :user, customer_token: nil }
    let(:customer_token) { ::WebmockHelpers::Stripe::Customer::STRIPE_CUSTOMER_ID }

    before(:each) { stub_stripe_customer_create }

    it "update user token and returns success result" do
      expect(user.customer_token).to be_falsey
      expect(stripe_customer_check).to be_success
      expect(user.reload.customer_token).to eq customer_token
      expect(stripe_customer_check.customer_token).to eq customer_token
    end
  end

  context "when customer_token not present and can't be retrieved" do
    let!(:user) { create :user, customer_token: nil }

    before(:each) { stub_stripe_customer_failure_create }

    it "respond with error" do
      expect(stripe_customer_check).not_to be_success
      expect(user.reload.customer_token).to be_falsey
      expect(stripe_customer_check.error).to be_present
    end
  end
end
