class PaginatingDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value, :entry_name, :offset_value, :total_count, :last_page?
end
