class Api::GameRoomsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :requires_login, only: [:index]

  def index
    # token = request.headers["Authorization"]

    # authenticate(Game.all)

    # if !valid_token?
    #   render json: {
    #     message: 'INFO ENTERED IS WRONG!!!'
    #   }, status: :unauthorized
    # else
    #   render json: Game.all
    # end
    #
    # requires_login()
    render json: GameRoom.all
  end

  def create
    @game_room = GameRoom.new
    @game_room.name = params[:name]
    @game_room.smallblind = params[:smallblind]
    @game_room.bigblind = params[:bigblind]

    if @game_room.save
      ActionCable.server.broadcast 'GameRoomsChannel', {
        id: @game_room.id,
        name: @game_room.name,
        smallblind: @game_room.smallblind,
        bigblind: @game_room.bigblind
      }

      render json: {
        id: @game_room.id,
        name: @game_room.name,
        smallblind: @game_room.smallblind,
        bigblind: @game_room.bigblind
      }

    else
      render json: {
        errors: @game_room.errors.full_messages
      }, status: :unprocessable_entity
    end

  end


  def show
    @game_room = GameRoom.find_by(id: params[:id])

    render json: @game_room
  end

  def update
    @game_room = GameRoom.find_by(id: params[:id])

  end



end
