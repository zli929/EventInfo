class AdvertisementsController < ApplicationController  
  before_filter :signed_in_user, only: [:create, :new, :destroy, :show, :update]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'
  # I don't understand why this code here is absolutely necessary
  # before_filter :correct_user,   only: :destroy
  
  def create
    @advertisement = current_user.advertisements.build(advertisement_params)
    if @advertisement.price.nil?
      @advertisement.price = -1
    end
    
    # Save images attached to the advertisement if there are any
    unless params[:advertisement][:advertisement_images_attributes].nil?
      i = 0
      while (i<6) do
        if !params[:advertisement][:advertisement_images_attributes][i.to_s].nil?
          @advertisement_image = @advertisement.advertisement_images.build()
          @advertisement_image.image = params[:advertisement][:advertisement_images_attributes][i.to_s][:image]
          @advertisement_image.save!
        end
        i += 1
      end
    end
    
    if @advertisement.save
      flash[:success] = "Your advertisement has been created!"
      redirect_to root_url
    else
      flash[:error] = @advertisement.errors.full_messages
      @feed_items = []
      render action: 'new'
    end
  end
  
  def edit
     @advertisement = Advertisement.find(params[:id])
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
    if params[:destroy]
        @advertisement.destroy and redirect_to(session[:return_to] || root_url) and return
    end
    
    @advertisement_images = @advertisement.advertisement_images
    @advertisement_comment  = @advertisement.advertisement_comments.build
    @current_comments = @advertisement.advertisement_comments.paginate(page: params[:page], :order => "updated_at DESC")
    
  end

  def destroy
    store_location    
    @advertisement = Advertisement.find(params[:id])
  
    if current_user?(User.find(@advertisement.user_id))
      @advertisement.status = false
      @advertisement.save!
    end
      
    redirect_to(session[:return_to] || root_url)
  end
  

  private 
    def advertisement_params
      params.require(:advertisement).permit(:content, :title, :price, :tag_list)
    end
end
