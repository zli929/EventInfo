class AdvertisementCommentsController < ApplicationController  
  def create
    store_location
    @advertisement_comment = current_user.advertisement_comments.build(advertisement_comment_params)
    
    if @advertisement_comment.save
      flash[:success] = "Thank you for your comment!"
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