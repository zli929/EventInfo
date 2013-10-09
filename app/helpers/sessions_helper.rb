module SessionsHelper
  def current_user?(user)
    user == current_user
  end
  
  def signed_in_user
    unless user_signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
  
  def store_location
    session[:return_to] = request.referrer
  end
end