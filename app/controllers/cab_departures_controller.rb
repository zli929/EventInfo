class CabDeparturesController < ApplicationController
  before_action :set_cab_departure, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in_user
  
  
  def show
    # Show display time for the user's departure
    
    if @cab_departure.latitude.nil? || @cab_departure.longitude.nil?
      flash[:error] = 'You have not entered a valid address'
      @cab_departures = []
      
    else
      nearby_departees = @cab_departure.nearbys(@cab_departure.location_buffer)
      @cab_departures = nearby_departees.where('user_id != ? AND party_size < ? AND cab_share_id IS NULL AND time <= ?', 
                    current_user.id, 5-@cab_departure.party_size, @cab_departure.time)

      nearby_cabs = CabShare.near(@cab_departure, @cab_departure.location_buffer)
      @cab_shares = @cab_departure.cab_share_id.nil? ? nearby_cabs.where('party_size < ? AND time <= ?', 5-@cab_departure.party_size, @cab_departure.time) 
                     : nearby_cabs.where('party_size < ? AND id <> ? AND time <= ?',
                     5-@cab_departure.cab_share.party_size, @cab_departure.cab_share_id,  
                     @cab_departure.time)  
    end
  end

  def new
    @cab_departure = current_user.cab_departures.build
  end

  def edit
  end

  def create
    #### BUG - GEOCODE FAILS WHEN YOU ENTER A WRONG ADDRESS ####
    
    # IF map coordinates exists and is not the default value, than use coordinates
    if params[:cab_departure][:google_coordinates] != "" && params[:cab_departure][:google_coordinates] != "(39.95023044499703, -75.17170786857605)"
       params[:cab_departure][:address] = params[:cab_departure][:google_coordinates]
    elsif params[:cab_departure][:address] != ""
       params[:cab_departure][:address] = params[:cab_departure][:address] +" Philadelphia, PA"
    end
    # raise params[:cab_departure][:address].to_yaml
    
    @cab_departure = current_user.cab_departures.build(cab_departure_params)
    @cab_departure.time = DateTime.strptime(params[:cab_departure][:prop_date] + " " + params[:cab_departure][:prop_time], "%m/%d/%Y %l:%M%p") - -18000.seconds
  
    respond_to do |format|
      if @cab_departure.save
        format.html { redirect_to @cab_departure}
        format.json { render action: 'show', status: :created, location: @cab_departure }
      else
        format.html { render action: 'new' }
        format.json { render json: @cab_departure.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    params[:cab_departure][:address] = params[:cab_departure][:google_coordinates]
    
    @cab_departure.time = DateTime.strptime(params[:cab_departure][:prop_date] + " " + params[:cab_departure][:prop_time], "%m/%d/%Y %l:%M%p") - -18000.seconds
    
    respond_to do |format|
      if @cab_departure.update(cab_departure_params)
        format.html { redirect_to @cab_departure, notice: 'Cab departure was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cab_departure.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def join
    joinee = params[:type] == 'existing_share' ? CabShare.find(params[:joinee]) : CabDeparture.find(params[:joinee])
    joiner = CabDeparture.find(params[:cab_departure_id])
    joiner.join(joinee)
    
    CabMailer.cab_update('joining', joiner.cab_share, joiner).deliver
    
    redirect_to joiner
  end

  def leave
    current_cab = CabShare.find(params[:cab])
    current_departee = CabDeparture.find(params[:cab_departure_id])
    current_cab.remove(current_departee)
    
    current_departee.cab_share = nil
    current_departee.save!
    
    CabMailer.cab_update('leaving', current_cab, current_departee).deliver
    
    redirect_to current_departee
  end

  def destroy
    @cab_departure.destroy
    respond_to do |format|
      format.html { redirect_to cab_departures_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cab_departure
      @cab_departure = CabDeparture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cab_departure_params
      @cab_deeparture_params ||= params.require(:cab_departure).permit(:address, :destination, :latitude, :longitude, 
         :location_buffer, :time, :time_buffer, :party_size)
    end
end
