class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :destroy, :update]
  
  def show
  end
   private
end
