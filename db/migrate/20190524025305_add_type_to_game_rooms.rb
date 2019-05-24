class AddTypeToGameRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :game_rooms, :type, :string
  end
end
