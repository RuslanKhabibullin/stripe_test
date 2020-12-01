class ItemDecorator < ApplicationDecorator
  delegate :id, :title, :description, :price
end
