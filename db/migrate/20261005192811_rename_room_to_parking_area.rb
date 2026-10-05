class RenameRoomToParkingArea < ActiveRecord::Migration[8.1]
  def change
    rename_table :rooms, :parking_areas
    rename_column :reservations, :room_id, :parking_area_id
  end
end
