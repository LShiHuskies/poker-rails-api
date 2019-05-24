class AddStyleToGameRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :game_rooms, :style, :string
  end
end
