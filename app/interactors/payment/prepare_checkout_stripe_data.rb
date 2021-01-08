module Payment
  class PrepareCheckoutStripeData
    include ::Interactor

    delegate :user, :item, :customer_token, to: :context
    delegate :item_payment_success_url, :item_url,
             to: "Rails.application.routes.url_helpers"
    delegate :default_url_options, to: "Rails.application.config.action_mailer"

    def call
      context.payment_data = payment_data
    end

    private

    def payment_data
      {
        payment_method_types: ["card"],
        mode: "payment",
        customer: customer_token,
        success_url: success_url,
        cancel_url: cancel_url,
        line_items: [
          {
            price_data: price_data,
            quantity: 1
          }
        ],
        metadata: metadata
      }
    end

    def price_data
      {
        currency: "usd",
        unit_amount: amount_in_cents,
        product_data: {
          name: item.title,
          description: "Item No: #{item.id}"
        }
      }
    end

    def metadata
      {
        purchase_time: purchase_time
      }
    end

    def success_url
      item_payment_success_url(
        default_url_options.merge(item_id: item.id)
      )
    end

    def cancel_url
      item_url(
        default_url_options.merge(id: item.id)
      )
    end

    def purchase_time
      ::I18n.l(
        ::Time.current.in_time_zone(time_zone),
        format: :time_with_zone
      )
    end

    def time_zone
      ::Time.zone.name
    end

    def amount_in_cents
      (100 * item.price.to_f).to_i
    end
  end
end
