class PaymentSession < ApplicationRecord
  belongs_to :user, -> { with_deleted }, inverse_of: :payment_sessions
  belongs_to :item

  validates :user_id, :item_id, presence: true

  scope :fulfilled, -> { where(state: :fulfilled) }

  state_machine initial: :created do
    event :pay do
      transition created: :paid
    end

    event :fulfill do
      transition paid: :fulfilled
    end

    event :payment_fail do
      transition created: :failed
    end

    state :paid, :fulfilled do
      validates :stripe_checkout_session_id,
                :stripe_payment_intent_id,
                :stripe_event_id,
                presence: true
    end
  end
end
