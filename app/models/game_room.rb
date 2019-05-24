class GameRoom < ApplicationRecord
  has_many :messages
  has_many :users, through: :user_game_rooms

  validates :name, presence: true, uniqueness: true
  validates :smallblind, presence: true
  validates :bigblind, presence: true
  validates :style, presence: true
end
