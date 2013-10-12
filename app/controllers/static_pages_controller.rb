require 'will_paginate/array'

class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @feed_items = Advertisement.find(:all, :order => "updated_at DESC").paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
