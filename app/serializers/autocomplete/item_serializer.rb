module Autocomplete
  class ItemSerializer < ::ActiveModel::Serializer
    attributes :id, :title
  end
end
