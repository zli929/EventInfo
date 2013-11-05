class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :destroy, :update]
  
  def show  
    redirect_to root_path
  end
  
  def single_signon_email_req
    @first_name = session['first_name']
    @last_name = session['last_name']
    @facebookuid = session['facebookuid']
    @password = Devise.friendly_token[0,20]
    
    reset_session
  end
  
   private
end
