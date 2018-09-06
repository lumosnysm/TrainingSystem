class UsersController < Devise::RegistrationsController
  layout "login"
  prepend_before_action :require_no_authentication, only: :cancel
  load_and_authorize_resource except: :create
  before_action :load_resource, :correct_user, only: %i(edit update destroy)
  before_action :configure_permitted_parameters, only: :update

  def edit; end

  def update
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to? :unconfirmed_email

    resource_updated = update_resource resource, account_update_params
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in(resource, scope: resource_name) if resource.supervisor?
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def destroy
    resource.destroy
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){redirect_to supervisor_users_path}
  end

  private

  def sign_up resource_name, resource
  end

  def sign_up_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :supervisor
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :account_update, keys: [:name]
  end

  def load_resource
    self.resource = User.find_by id: params[:user_id]
    return if self.resource
    flash[:danger] = t ".user_not_found"
    redirect_back fallback_location: root_url
  end

  def correct_user
    return if current_user.supervisor?
    return if current_user == self.resource
    flash[:danger] = t ".not_correct_user"
    redirect_back fallback_location: root_url
  end
end
