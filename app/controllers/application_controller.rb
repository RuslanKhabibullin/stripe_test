require "application_responder"

class ApplicationController < ActionController::Base
  include Authentication

  self.responder = ApplicationResponder
  respond_to :html

  before_action :authenticate_user!
end
