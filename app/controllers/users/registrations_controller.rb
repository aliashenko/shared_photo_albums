class Users::RegistrationsController < Devise::RegistrationsController
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected
  def update_resource(resource, params)
    if (params[:remove_avatar] == "1" && !params[:avatar].nil?)
      params[:remove_avatar] = nil
    end
    is_google_account = !resource.provider.blank?
    if !is_google_account
      resource.update_with_password(params)
    else
      resource.update_without_password(params.except(:current_password))
    end
  end
end