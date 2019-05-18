class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :email
      t.string :password_digest
      t.boolean :admin, :default => false
      t.float :totalCash, :default => 0.00
      t.float :inPlayCash
      t.float :bet

      t.timestamps
    end
  end
end
