class RemoveRoomIntroductionFromRooms < ActiveRecord::Migration[6.1]
  def change
    remove_column :rooms, :room_introduction, :text
  end
end
