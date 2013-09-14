class ApplicationController < ActionController::Base
  # before_filter :authenticate_user_from_token!
  # before_filter :authenticate_user!
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private
  
    def authenticate_user_from_token!
      
    user_token = params[:auth_token].presence
    user       = user_token && User.find_by_authentication_token(user_token)
 
      if user
        # Notice how we use Devise.secure_compare to compare the token
        # in the database with the token given in the params, mitigating
        # timing attacks.
        sign_in user, store: false
      end
    end
end
