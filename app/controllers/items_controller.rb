class ItemsController < ApplicationController
  skip_before_action :authenticate_user!

  expose_decorated :items, -> { Item.order(:created_at).page params[:page] }
  expose_decorated :item

  def index
  end

  def show
  end
end
