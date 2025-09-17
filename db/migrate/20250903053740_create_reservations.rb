class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :checkin_day
      t.date :checkout_day
      t.integer :number_of_guests
      t.integer :number_of_night
      t.datetime :confirmed_day
      t.decimal :payment
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
