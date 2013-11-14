class CabShare < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, :if => :longitude_changed?
  
  has_many :cab_departures
end
