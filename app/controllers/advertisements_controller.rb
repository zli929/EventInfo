class AdvertisementsController < ApplicationController  
  before_filter :signed_in_user, only: [:create, :new, :destroy, :show, :update]
  # I don't understand why this code here is absolutely necessary
  # before_filter :correct_user,   only: :destroy
  
  def create
    @advertisement = current_user.advertisements.build(advertisement_params)
    
    # Save images attached to the advertisement if there are any
    unless params[:advertisement][:advertisement_images_attributes].nil?
      i = 0
      while (!params[:advertisement][:advertisement_images_attributes][i.to_s].nil? && i<6) do
        @advertisement_image = @advertisement.advertisement_images.build()
        @advertisement_image.image = params[:advertisement][:advertisement_images_attributes][i.to_s][:image]
        @advertisement_image.save!
        i += 1
      end
    end
    
    if @advertisement.save
      flash[:success] = "Your advertisement has been created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def new
    @advertisement = current_user.advertisements.build
    5.times {
      @advertisement.advertisement_images.build
    }
  end
  
  def update
    @advertisement = Advertisement.find(params[:id])
    if @advertisement.update_attributes(advertisement_params)
      flash[:success] = 'Successfully updated advertisement.'
      redirect_to @advertisement
    else
      render :action => 'edit'
    end
  end

  def show
    @advertisement = Advertisement.find(params[:id])
    @advertisement_images = @advertisement.advertisement_images
    @advertisement_comment  = @advertisement.advertisement_comments.build
    @current_comments = @advertisement.advertisement_comments.paginate(page: params[:page])
  end

  def destroy
    store_location    
    @advertisement = Advertisement.find(params[:id])
  
    if current_user?(User.find(@advertisement.user_id))
      @advertisement.destroy
    end
      
    redirect_to(session[:return_to] || root_url)
  end

  private 
    def advertisement_params
      params.require(:advertisement).permit(:content, :title)
    end
end