class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :destroy, :update]
  
  def show  
    redirect_to root_path
  end
  
   private
end
