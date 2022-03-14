class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :update, :destroy]
  before_action :authorized

  # GET /invites
  def index
    @invites = Invite.all

    render json: @invites
  end

  # GET /events_for_guest
  def index_for_guest
    @invites = Invite.by_user(params[:id])
    options = {include: [:event]}
    render json: InviteSerializer.new(@invites,options)
  end

    # GET /guests_for_event
    def index_for_event
    @invites = Invite.by_event(params[:id])
    options = {include: [:user]} 
    render json: InviteSerializer.new(@invites,options)
  end

  # GET /invites/1
  def show
    render json: @invite
  end

  # POST /invites
  def create
    @invite = Invite.new(invite_params)

    if @invite.save
      render json: @invite, status: :created, location: @invite
    else
      render json: @invite.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invites/1
  def update
    if @invite.update(invite_params)
      render json: @invite
    else
      render json: @invite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invites/1
  def destroy
    @invite.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invite
      @invite = Invite.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invite_params
      params.require(:invite).permit(:user_id, :event_id, :checkinTime, :inviteStatus, :checkinStatus, :phoneNumber, :coverChargePaid)
    end
end
