class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    
    user = FbGraph::User.me(request.env["omniauth.auth"].credentials.token)
    user = user.fetch
    
    valid_group = !user.groups.detect{|f| f.identifier == '110130752488165'}.nil?
    
    if valid_group 
      @user = User.find_for_oauth(request.env["omniauth.auth"].provider, 
                                  request.env["omniauth.auth"].uid, 
                                  request.env["omniauth.auth"].extra.raw_info.first_name, 
                                  request.env["omniauth.auth"].extra.raw_info.last_name, 
                                  request.env["omniauth.auth"].info.email, 
                                  current_user)
    end

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
            
    else
      session["devise.omniauth_data"] = request.env["omniauth.auth"].uid
      redirect_to new_user_registration_url
    end
  end
end