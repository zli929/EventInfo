require 'will_paginate/array'

class StaticPagesController < ApplicationController
  def home
    if signed_in?
      if params[:tag]
        @feed_items = Advertisement.where(status: true).tagged_with(params[:tag]).paginate(page: params[:page], :per_page => 25, :order => "updated_at DESC")
      else 
        @feed_items = Advertisement.where(status: true).paginate(page: params[:page], :per_page => 25, :order => "updated_at DESC")
      end
      @tags = ActsAsTaggableOn::Tag.all
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
  
  def disclaimer
  end
end
