require 'will_paginate/array'

class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @feed_items = Advertisement.all.paginate(page: params[:page], :per_page => 50, :order => "updated_at DESC")
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
