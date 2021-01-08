class ItemPolicy < ApplicationPolicy
  def buy?
    !user.bought_items.exists?(id: record.id)
  end
end
