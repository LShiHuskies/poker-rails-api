class UserGameRoom < ApplicationRecord
  belongs_to :user
  belongs_to :game_room
end
