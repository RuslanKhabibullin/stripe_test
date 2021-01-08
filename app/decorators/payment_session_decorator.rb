class PaymentSessionDecorator < ApplicationDecorator
  delegate :id, :state

  def item_title
    object.item.title
  end

  def item_id
    object.item.id
  end

  def formatted_creation_time
    I18n.l(
      object.created_at.in_time_zone(time_zone),
      format: :time_with_zone
    )
  end

  def state_with_proper_color
    h.tag.span(object.state, class: "payment-#{object.state}")
  end

  private

  def time_zone
    ::Time.zone.name
  end
end
