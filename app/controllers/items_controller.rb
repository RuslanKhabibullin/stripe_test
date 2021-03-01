class ItemsController < ApplicationController
  skip_before_action :authenticate_user!

  expose_decorated :items, -> { Item.order(:created_at).page params[:page] }
  expose_decorated :item

  def index
  end

  def show
  end

  def autocomplete
    render(
      json: Elasticsearch::ItemsSearch.new(params[:term]).call.objects,
      each_serializer: Autocomplete::ItemSerializer
    )
  end
end
