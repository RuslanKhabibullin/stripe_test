module Payment
  class CreatePayment
    include ::Interactor

    delegate :user, :item, to: :context

    def call
      context.payment = user.payment_sessions.create(item: item)
      context.fail!(error: context.payment.errors.full_messages.join(". ")) if context.payment.invalid?
    end

    def rollback
      context.payment.destroy
    end
  end
end
