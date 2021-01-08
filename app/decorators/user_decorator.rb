class UserDecorator < ApplicationDecorator
  delegate :id, :first_name, :last_name, :email, :full_name

  def already_bought?(item)
    if object.association(:bought_items).loaded?
      object.bought_items.find { |bough_item| bough_item.id == item.id }
    else
      object.bought_items.exists?(id: item.id)
    end
  end
end
