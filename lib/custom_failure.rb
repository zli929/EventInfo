class CustomFailure < Devise::FailureApp
  def redirect_url
    if warden_options[:scope] == :user
      session[:return_to] = request.referrer
      signin_path
    else
      session[:return_to] = request.referrer
      signin_path
    end
  end
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end