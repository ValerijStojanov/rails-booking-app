main_garage = ParkingArea.find_or_create_by!(
  name: "Main Garage",
  capacity: 3
)

visitor_lot = ParkingArea.find_or_create_by!(
  name: "Visitor Lot",
  capacity: 1
)

Reservation.find_or_create_by!(
  name: "Jan Novak",
  parking_area: main_garage,
  start_date: Time.zone.parse("2026-10-15 09:00"),
  end_date: Time.zone.parse("2026-10-15 11:00")
)

Reservation.find_or_create_by!(
  name: "Petr Svoboda",
  parking_area: main_garage,
  start_date: Time.zone.parse("2026-10-15 10:00"),
  end_date: Time.zone.parse("2026-10-15 12:00")
)

Reservation.find_or_create_by!(
  name: "Eva Dvorak",
  parking_area: visitor_lot,
  start_date: Time.zone.parse("2026-10-15 13:00"),
  end_date: Time.zone.parse("2026-10-15 15:00")
)
