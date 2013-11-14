class CabDeparture < ActiveRecord::Base
  belongs_to :user
  belongs_to :cab_shares
  
  attr_accessor :prop_date, :prop_time
    
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  
  def get_departure_datetime
    utc_time = time + ActiveSupport::TimeZone['Eastern Time (US & Canada)'].utc_offset.seconds
    utc_time.strftime('%b %d, %Y') +" at " + utc_time.strftime('%l:%M %p')    
  end
end
