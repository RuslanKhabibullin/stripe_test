require "rails_helper"

describe Payment::CreatePayment do
  subject(:create_payment) { described_class.call(user: user, item: item) }

  let!(:user) { create :user }
  let!(:item) { create :item }

  context "when creation success" do
    it "successfully create entity" do
      expect(user.payment_sessions).to be_empty
      expect(create_payment).to be_success
      expect(user.reload.payment_sessions).not_to be_empty
    end
  end

  context "when creation failed" do
    let!(:item) { nil }

    it "respond with error" do
      expect(create_payment).not_to be_success
      expect(create_payment.error).to eq "Item must exist. Item can't be blank"
    end
  end
end
