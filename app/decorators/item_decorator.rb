class ItemDecorator < ApplicationDecorator
  include ActionView::Helpers::NumberHelper

  delegate :id, :title, :description, :price

  def price_with_currency
    "#{number_with_precision(price, precision: 2)}$"
  end

  def purchase_json_data
    {
      id: id
    }.to_json
  end
end
