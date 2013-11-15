class CabShare < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, :if => :longitude_changed?
  
  has_many :cab_departures
  
  def add(joinee)
    self.latitude = (self.latitude * self.party_size + joinee.latitude * joinee.party_size)/(self.party_size + joinee.party_size)
    self.longitude = (self.longitude * self.party_size + joinee.longitude * joinee.party_size)/(self.party_size + joinee.party_size)
    self.party_size = party_size + joinee.party_size
    self.save!
  end
  
  def remove(leaver)
    self.latitude = (self.latitude * self.party_size - leaver.latitude * leaver.party_size)/(self.party_size - leaver.party_size)
    self.longitude = (self.longitude * self.party_size - leaver.longitude * leaver.party_size)/(self.party_size - leaver.party_size)
    self.party_size = party_size - leaver.party_size
    self.save!
  end
end
