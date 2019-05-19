class User < ApplicationRecord
  has_many :messages
  has_many :game_rooms, through: :user_game_rooms

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
