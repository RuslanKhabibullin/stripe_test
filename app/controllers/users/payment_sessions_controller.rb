module Users
  class PaymentSessionsController < ::ApplicationController
    expose_decorated :payment_sessions, -> { fetch_payment_sessions }

    def index
    end

    private

    def fetch_payment_sessions
      current_user
        .payment_sessions
        .includes(:item)
        .order(:updated_at)
        .page params[:page]
    end
  end
end
