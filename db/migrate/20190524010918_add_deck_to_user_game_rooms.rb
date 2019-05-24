class AddDeckToUserGameRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :user_game_rooms, :deck, :string
  end
end
