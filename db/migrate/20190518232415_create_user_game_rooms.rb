class CreateUserGameRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_game_rooms do |t|
      t.integer :user_id
      t.integer :game_room_id

      t.timestamps
    end
  end
end
