class ApplicationController < ActionController::Base
  include SessionsHelper
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
        sign_in user, store: false
      end
    end
end
