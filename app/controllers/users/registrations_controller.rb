class Users::RegistrationsController < Devise::RegistrationsController
  protected
    def after_update_path_for(resource)
      user_path(resource)
    end
    
    def after_inactive_sign_up_path_for(resource)
      after_signup_path # <- Path you want to redirect the user to.
    end
    
  private 
   # def user_params
   #   params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
   # end
    
    def sign_up_params
      params.require(:user).permit(:facebookuid, :email, :password, :password_confirmation, :first_name, :last_name)
    end
end