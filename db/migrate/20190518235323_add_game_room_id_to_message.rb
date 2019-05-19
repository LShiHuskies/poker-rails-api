class AddGameRoomIdToMessage < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :game_room_id, :integer
  end
end
