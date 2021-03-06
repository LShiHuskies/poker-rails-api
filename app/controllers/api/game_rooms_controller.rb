class Api::GameRoomsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :requires_login, only: [:index]

  def index
    if params[:style]
      @game_rooms = GameRoom.where(style: params[:style])
    else
      @game_rooms = GameRoom.all
    end

    ActionCable.server.broadcast 'GameRoomsChannel', {
      game_rooms: @game_rooms
    }

    render json: @game_rooms
  end

  def create
    @game_room = GameRoom.new
    @game_room.name = params[:name]
    @game_room.smallblind = params[:smallblind]
    @game_room.bigblind = params[:bigblind]
    @game_room.style = params[:style]

    response = JSON.parse RestClient.get "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"

    @game_room.deck = response["deck_id"]

    if @game_room.save

      ActionCable.server.broadcast 'GameRoomsChannel', {
        id: @game_room.id,
        name: @game_room.name,
        smallblind: @game_room.smallblind,
        bigblind: @game_room.bigblind,
        deck: @game_room.deck
      }

      render json: {
        id: @game_room.id,
        name: @game_room.name,
        smallblind: @game_room.smallblind,
        bigblind: @game_room.bigblind,
        deck: @game_room.deck
      }

    else
      render json: {
        errors: @game_room.errors.full_messages
      }, status: :unprocessable_entity
    end

  end


  def show
    if (params[:id])
      @game_room = GameRoom.find_by(id: params[:id])
    end

    render json: @game_room
  end

  def update
    @game_room = GameRoom.find_by(id: params[:id])

    if @game_room.deck == nil
      response = JSON.parse RestClient.get "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1"

      @game_room.deck = response["deck_id"]
    end

    if params['user_id']
      @user = User.find_by(id: params['user_id'])
      @game_room.users << @user

      @user_game_room = UserGameRoom.new
      @user_game_room.user_id = params['user_id']
      @user_game_room.game_room_id = @game_room.id
      @user_game_room.deck = @game_room.deck


      if @user_game_room.save
          ActionCable.server.broadcast 'GameRoomsChannel', {
            id: @game_room.id,
            name: @game_room.name,
            smallblind: @game_room.smallblind,
            bigblind: @game_room.bigblind,
            deck: @game_room.deck,
            users: @game_room.users
          }
      end

    end


    if params[:style]
     @game_room.update(style: params[:style])
    end

    render json: @game_room
  end

  def destroy
    @game_room = GameRoom.find_by(id: params[:id])

    if @game_room.destroy

      render json: @game_room
    else
      render json: {
        errors: @game_room.errors.full_messages
      }, status: :unprocessable_entity
    end

  end



end
