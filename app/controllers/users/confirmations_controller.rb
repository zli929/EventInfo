class Users::ConfirmationsController < Devise::OmniauthCallbacksController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    
    unless self.resource.facebookuid.nil?
      sign_in self.resource, :event => :authentication 
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      redirect_to root_path
      return
    end

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
      return
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render :new }
      return
    end
  end
  
  protected
    # The path used after resending confirmation instructions.
    def after_resending_confirmation_instructions_path_for(resource_name)
      new_session_path(resource_name) if is_navigational_format?
    end

    # The path used after confirmation.
    def after_confirmation_path_for(resource_name, resource)
      if signed_in?
        signed_in_root_path(resource)
      else
        new_session_path(resource_name)
      end
    end
end