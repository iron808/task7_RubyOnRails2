class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.string :room_details
      t.decimal :room_rate
      t.string :facility_address
      t.text :room_introduction

      t.timestamps
    end
  end
end
