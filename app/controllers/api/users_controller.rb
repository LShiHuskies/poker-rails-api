class Api::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :requires_login, only: [:index, :show, :users_games]

  def index
    render json: User.all
  end

  def create
    @user = User.new

    @user.username = params[:username]
    @user.firstname = params[:firstname]
    @user.lastname = params[:lastname]
    @user.email = params[:email]
    @user.password = params[:password]

    if @user.save
      ActionCable.server.broadcast 'UsersChannel', {
        username: @user.username,
        id: @user.id,
        firstname: @user.firstname,
        lastname: @user.lastname,
        email: @user.email
      }

      render json: @user
    else
      render json: {
        errors: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by(id: params[:id])

    render json: {
      id: @user.id,
      username: @user.username,
      firstname: @user.firstname,
      lastname: @user.lastname,
      email: @user.email,
      admin: @user.admin,
      totalCash: @user.totalCash,
      inPlayCash: @user.inPlayCash
    }

  end

  def update
    @user = User.find_by(id: params[:id])
    # if params['game_room_id']
    #   @game_room = GameRoom.find_by(id: params['game_room_id'])
    #   @user.game_rooms << @game_room
    # end
    #
    # ActionCable.server.broadcast 'UsersChannel', {
    #   username: @user.username,
    #   id: @user.id,
    #   game_rooms: @user.game_rooms
    # }

    render json: @user
  end



end
