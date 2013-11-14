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
      @cab_departures = nearby_departees.where('time <= ?', @cab_departure.time)
    end
  end

  def new
    @cab_departure = current_user.cab_departures.build
  end

  def edit
  end

  def create
    #### BUG - GEOCODE FAILS WHEN YOU ENTER A WRONG ADDRESS ####
    
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
    cab_departure = CabDeparture.find(params[:id])
    
    raise params.to_yaml
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
      params.require(:cab_departure).permit(:address, :destination, :latitude, :longitude, :location_buffer, :time, :time_buffer)
    end
end
