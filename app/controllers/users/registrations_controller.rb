class Users::RegistrationsController < Devise::RegistrationsController

  protected
    def after_update_path_for(resource)
      user_path(resource)
    end
    
  private 
   # def user_params
   #   params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
   # end
    
    
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
end