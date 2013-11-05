class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_oauth(request.env["omniauth.auth"].provider, 
                                request.env["omniauth.auth"].uid, 
                                request.env["omniauth.auth"].extra.raw_info.first_name, 
                                request.env["omniauth.auth"].extra.raw_info.last_name, 
                                request.env["omniauth.auth"].info.email, 
                                request.env["omniauth.auth"].credentials.token,
                                current_user)                         
    
    # Confirmed user is pre-existing or is a member of Wharton facebook group
    if !@user.nil? && @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    
    # Successfully authenticated through facebook, but cannot confirm in facebook group. Need to verify Wharton email address
    elsif !request.env["omniauth.auth"].extra.raw_info.first_name.nil? && !request.env["omniauth.auth"].extra.raw_info.last_name.nil?
      session['first_name'] = request.env["omniauth.auth"].extra.raw_info.first_name
      session['last_name'] = request.env["omniauth.auth"].extra.raw_info.last_name
      session['facebookuid'] = request.env["omniauth.auth"].uid
      
      redirect_to single_signon_email_req_new_user_path
      
    # Facebook login in failed completely, redirect ot full login screen  
    else
      session["devise.omniauth_data"] = request.env["omniauth.auth"].uid
      flash[:alert] = 'We were not able to log you in using Facebook, please fill out the form below. We apologize for the inconvenience'
      redirect_to new_user_registration_url
    end
  end
end