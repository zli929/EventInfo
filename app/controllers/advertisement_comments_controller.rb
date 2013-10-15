class AdvertisementCommentsController < ApplicationController  
  def create
    
    store_location
    if params[:commit] == 'Public comment'
  
      @advertisement_comment = current_user.advertisement_comments.build(advertisement_comment_params)
      
      if @advertisement_comment.save
        flash[:success] = "Thank you for your comment!"
      end
    
    elsif params[:commit] == 'Email poster' 
      advertisement = Advertisement.find(params[:advertisement_comment][:advertisement_id])
      
      poster = advertisement.user
      messager = current_user
      message = params[:advertisement_comment][:comment]
     
      AdvertisementMailer.advertisement_update(messager, poster, message, advertisement).deliver
           
      flash[:success] = "Your message has been sent to " + poster.first_name + "!"
    end
    
    redirect_to(session[:return_to] || root_url)
  end
  
   def destroy
    store_location    
    @advertisement_comment = AdvertisementComment.find(params[:id])
     
    if current_user?(User.find(@advertisement_comment.user_id))
      @advertisement_comment.destroy
    end 
    
    redirect_to(session[:return_to] || root_url)
  end

  
    private 
    def advertisement_comment_params
      params.require(:advertisement_comment).permit(:comment, :advertisement_id)
    end
end