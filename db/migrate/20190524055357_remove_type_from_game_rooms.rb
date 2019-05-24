class RemoveTypeFromGameRooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :game_rooms, :type, :string
  end
end
