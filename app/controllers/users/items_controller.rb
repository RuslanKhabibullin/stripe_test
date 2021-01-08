module Users
  class ItemsController < ::ApplicationController
    expose_decorated :items, -> { current_user.bought_items.order(:created_at).page params[:page] }

    def index
    end
  end
end
