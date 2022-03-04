class OrganizationEventsController < ApplicationController
  before_action :set_organization_event, only: [:show, :update, :destroy]
  before_action :authorized

  # GET /organization_events
  def index
    @organization_events = OrganizationEvent.all

    render json: @organization_events
  end

  # GET /organization_events/1
  def show
    render json: @organization_event
  end

  # POST /organization_events
  def create
    @organization_event = OrganizationEvent.new(organization_event_params)

    if @organization_event.save
      render json: @organization_event, status: :created, location: @organization_event
    else
      render json: @organization_event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organization_events/1
  def update
    if @organization_event.update(organization_event_params)
      render json: @organization_event
    else
      render json: @organization_event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /organization_events/1
  def destroy
    @organization_event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization_event
      @organization_event = OrganizationEvent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def organization_event_params
      params.require(:organization_event).permit(:organization_id, :event_id)
    end
end
