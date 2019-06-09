class CreateSeats < ActiveRecord::Migration[5.2]
  def change
    create_table :seats do |t|
      t.integer :game_room_id
      t.integer :user_id

      t.timestamps
    end
  end
end
