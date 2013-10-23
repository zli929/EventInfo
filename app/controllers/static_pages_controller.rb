require 'will_paginate/array'

class StaticPagesController < ApplicationController
  def home
    if signed_in?
      if params[:tag]
        @feed_items = Advertisement.tagged_with(params[:tag]).paginate(page: params[:page], :per_page => 25, :order => "updated_at DESC")
      else 
        @feed_items = Advertisement.all.paginate(page: params[:page], :per_page => 25, :order => "updated_at DESC")
      end
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
  
  def after_signup
  end
end
