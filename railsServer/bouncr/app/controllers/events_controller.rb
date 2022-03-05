class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :authorized
  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  def index_for_host
    @events = Event.forHost(params[:id]).alphabetical
    options = {}
    render json: EventSerializer.new(@events,options)
  end

  def index_for_guest
    @events = Event.forGuest(params[:id]).alphabetical
    options = {}
    render json: EventSerializer.new(@events,options)
  end

  # GET /events/1
  def show
    options = {}
    render json: EventSerializer.new(@event,options)
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :startTime, :endTime, :street1, :street2, :city, :zip, :description, :attendenceVisible, :friendsAttendingVisible, :attendenceCap, :coverCharge, :isOpenInvite, :venueLatitude, :venueLongitude)
    end
end
