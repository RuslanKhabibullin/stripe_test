module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def update_resource(resource, params)
      passwords_blank?(params) ? resource.update(params) : resource.update_with_password(params)
    end

    def account_update_params
      params = devise_parameter_sanitizer.sanitize(:account_update)

      if passwords_blank?(params)
        params.except(:password, :password_confirmation, :current_password)
      else
        params
      end
    end

    def passwords_blank?(params)
      %i[
        password
        password_confirmation
        current_password
      ].all? { |param_name| params[param_name].blank? }
    end
  end
end
