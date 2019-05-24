class AddDeckToGameRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :game_rooms, :deck, :string
  end
end
