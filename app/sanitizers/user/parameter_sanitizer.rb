class User
  class ParameterSanitizer < Devise::ParameterSanitizer
    SIGN_UP_PARAMS = %i[
      email
      first_name
      last_name
      password
      password_confirmation
    ].freeze

    ACCOUNT_UPDATE_PARAMS = %i[
      email
      first_name
      last_name
      password
      password_confirmation
      current_password
    ].freeze

    def initialize(*)
      super
      permit(:sign_up, keys: SIGN_UP_PARAMS)
      permit(:account_update, keys: ACCOUNT_UPDATE_PARAMS)
    end
  end
end
