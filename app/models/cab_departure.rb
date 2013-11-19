class CabDeparture < ActiveRecord::Base
  belongs_to :user
  belongs_to :cab_share
  

  attr_accessor :prop_date, :prop_time, :google_coordinates
    
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  # after_validation :reverse_geocode, :if => :long_changed?  STILL THROWING AN ERROR
  
  def get_departure_datetime
    utc_time = time + ActiveSupport::TimeZone['Eastern Time (US & Canada)'].utc_offset.seconds
    utc_time.strftime('%b %d, %Y') +" at " + utc_time.strftime('%l:%M %p')    
  end
  
  def join(joinee)
    if self.party_size + joinee.party_size < 5
      if self.cab_share.nil?
        # Create a new CabShare object if neither have any members
        
        if self.party_size + joinee.party_size < 5
          if !joinee.is_a?(CabShare)
            
            # Create new cab share for these two individuals
              new_cab_share = CabShare.new(:latitude => self.latitude, :longitude => self.longitude, :time => self.time, :party_size => self.party_size)
      
              if new_cab_share.add(joinee)
                
                # Cab share has been created successfully. Now add self and joinee and we're done!
                self.cab_share = new_cab_share
                joinee.cab_share = new_cab_share
                
                self.save!
                joinee.save!
              end
          else 
            joinee.add(self)
            
            self.cab_share = joinee
            self.save!
          end
        else 
          flash[:error] = 'You have too many people for 1 cab'
        end
      else
        existing_cab = self.cab_share
        
        if existing_cab.party_size + joinee.party_size < 5
          if !joinee.is_a?(CabShare)
            existing_cab.add(joinee)
            joinee.cab_share = existing_cab
            joinee.save!
          else 
            joinee.add(existing_cab)
            
            #Block!!!
            existing_cab.cab_departures.each do |cab_departure|
              cab_departure.cab_share = joinee
              cab_departure.save!
            end
            existing_cab.delete
          end
        else
          flash[:error] = 'You have too many people for 1 cab'
        end
      end
    end
  end
end
