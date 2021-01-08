module Items
  class PaymentsController < ::ApplicationController
    expose :item

    def create
      authorize item, :buy?

      if item_checkout.success?
        render json: { id: item_checkout.stripe_session.id }, status: :created
      else
        render json: { error: item_checkout.error }, status: :unprocessable_entity
      end
    end

    def success
    end

    def cancel
    end

    private

    def item_checkout
      @item_checkout ||= ::Payment::ItemCheckout.call(
        user: current_user,
        item: item
      )
    end
  end
end
