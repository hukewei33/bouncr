class UsersController < ApplicationController

    before_action :authorized, only: [:auto_login, :destroy,:update]
    before_action :set_user, only: [:show, :update, :destroy]

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def show
    render json: @user
  end

  def index_for_hosting
    @users = User.for_hosting(params[:id])
    render json: UserSerializer.new(@users,{})
  end

  def index_for_invited
    @users = User.for_invited(params[:id])
    render json: UserSerializer.new(@users,{})
  end

  def index_for_search
    @users = User.search(params[:term])
    render json: UserSerializer.new(@users,{})
  end

  def index_friends
    @users = User.initiatedFriendship(params[:id])+(User.recievedFriendship(params[:id]))
    render json: UserSerializer.new(@users,{})
  end

  def update
    if @user.update(user_params)
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token}
    else
        render json: {error: "Invalid update"}
    end
  end

  def destroy
    @user.destroy
    if !@user.destroyed?
      render json: {error: "Invalid destroy"}
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end


  def auto_login
    render json: UserSerializer.new(@user,{}) 
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:username, :password, :email,:firstName,:lastName,:phoneNumber)
  end

end
