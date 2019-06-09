class Api::SeatsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :requires_login, only: [:index]

  def index
    @seats = Seat.all
    render json: @seats
  end

  def create
    @seat = Seat.new

    @seat.user_id = params[:user_id]
    @seat.game_room_id = params[:game_room_id]

    @user = User.find_by(id: params[:user_id])

    if @seat.save
      ActionCable.server.broadcast 'GameRoomsChannel', {
        id: @seat.id,
        user_id: @seat.user_id,
        name: @user.username,
        game_room_id: @seat.game_room_id
      }

      render json: @seat
    else
      render json: {
        errors: @seat.errors.full_messages
      }, status: :unprocessable_entity
    end


    def destroy
      @seat = Seat.find(params[:id])
      @seat.destroy
    end


  end

end
