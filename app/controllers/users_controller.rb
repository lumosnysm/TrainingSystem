class UsersController < Devise::RegistrationsController
  layout "login"
  prepend_before_action :require_no_authentication, only: [:cancel]
  load_and_authorize_resource except: :create

  private

  def sign_up(resource_name, resource)
  end

  def sign_up_params
    params.require(:user).permit :email, :password,
      :password_confirmation, :supervisor
  end
end
