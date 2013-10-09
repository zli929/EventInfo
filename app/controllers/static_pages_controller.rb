class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @feed_items = Advertisement.all.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
