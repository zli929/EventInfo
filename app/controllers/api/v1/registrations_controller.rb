class Api::V1::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    @user = User.new
    @user.skip_confirmation!
    @user.update_attributes(user_params)
    if resource.save
      sign_in resource
        render :status => 200,
               :json => { :success => true,
                        :info => "Registered",
                        :data => { :user => resource,
                                   :auth_token => current_user.authentication_token } }
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => resource.errors,
                        :data => {} }
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password_confirmation, :password)
    end
end