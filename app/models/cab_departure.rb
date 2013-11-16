class CabDeparture < ActiveRecord::Base
  belongs_to :user
  belongs_to :cab_share
  
  attr_accessor :prop_date, :prop_time, :google_coordinates
    
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  
  def get_departure_datetime
    utc_time = time + ActiveSupport::TimeZone['Eastern Time (US & Canada)'].utc_offset.seconds
    utc_time.strftime('%b %d, %Y') +" at " + utc_time.strftime('%l:%M %p')    
  end
  
  def join(joinee)
    # Test to see if the party sizes are going to be a problem
    if self.party_size + joinee.party_size < 5
      
      # Create a new CabShare object if neither have any members
      if self.cab_share_id.nil? && joinee.cab_share_id.nil?
        
        # Create new cab share for these two individuals
        if self.party_size + joinee.party_size < 5
          new_cab_share = CabShare.new(:latitude => self.latitude, :longitude => self.longitude, :time => self.time, :party_size => self.party_size)
  
          if new_cab_share.add(joinee)
            
            # Cab share has been created successfully. Now add self and joinee and we're done!
            self.cab_share_id = new_cab_share.id
            joinee.cab_share_id = new_cab_share.id
            
            self.save!
            joinee.save!
          end
        end
        
      else !self.cab_share_id.nil? || !joinee.cab_share_id.nil?  
        
        if self.cab_share_id.nil?
            if joinee.cab_share_id.nil?
              joinee.cab_share.add(self)
              self.cab_share_id = joinee.cab_share_id
              self.save!     
            else
              joinee.cab_share.add(self.cab_share)
              
              nolonger_need_cab = self.cab_share
              nolonger_need_cab.cab_departures.each do |cab_departure|
                cab_departure.cab_share_id = joinee.cab_share_id
                cab_departure.save!
              end
              
              nolonger_need_cab.delete
            end                    
        else
            self.cab_share.add(joinee)
            joinee.cab_share_id = self.cab_share_id
            joinee.save!
        end
        
      end
    end
  end
end
