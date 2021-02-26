class Item < ApplicationRecord
  validates :title, presence: true
  validates :price, numericality: { greater_than: 0 }

  update_index("items#item") do
    self if saved_change_to_title? || saved_change_to_description?
  end
end
