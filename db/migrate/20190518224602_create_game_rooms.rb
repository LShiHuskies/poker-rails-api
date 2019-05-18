class CreateGameRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :game_rooms do |t|
      t.string :name
      t.float :smallblind
      t.float :bigblind
      t.string :dealer

      t.timestamps
    end
  end
end
