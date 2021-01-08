module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    redirect_to root_path, flash: { warning: "You are not authorized to perform this action." }
  end
end
