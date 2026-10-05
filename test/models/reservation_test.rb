require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  test "reservation is valid when end date is after start date" do
    parking_area = ParkingArea.new(name: "Main parking", capacity: 2)

    reservation = Reservation.new(
      name: "Jan",
      parking_area: parking_area,
      start_date: Time.zone.parse("2026-10-06 10:00"),
      end_date: Time.zone.parse("2026-10-06 11:00")
    )

    assert reservation.valid?
  end

  test "reservation is invalid when end date equals start date" do
    parking_area = ParkingArea.new(name: "Main parking", capacity: 2)

    reservation = Reservation.new(
      name: "Jan",
      parking_area: parking_area,
      start_date: Time.zone.parse("2026-10-06 11:00"),
      end_date: Time.zone.parse("2026-10-06 11:00")
    )

    refute reservation.valid?
  end

  test "reservation is invalid when end date is before start date" do
    parking_area = ParkingArea.new(name: "Main parking", capacity: 2)

    reservation = Reservation.new(
      name: "Jan",
      parking_area: parking_area,
      start_date: Time.zone.parse("2026-10-06 10:00"),
      end_date: Time.zone.parse("2026-10-06 09:00")
    )

    refute reservation.valid?
  end

  test "reservation is invalid when capacity is exceeded" do
    parking_area = ParkingArea.create!(name: "Main parking", capacity: 1)

    existing_reservations = Reservation.create!(
      name: "Jan",
      parking_area: parking_area,
      start_date: Time.zone.parse("2026-10-06 10:00"),
      end_date: Time.zone.parse("2026-10-06 12:00")
    )

    reservation = Reservation.new(
      name: "Petr",
      parking_area: parking_area,
      start_date: Time.zone.parse("2026-10-06 10:00"),
      end_date: Time.zone.parse("2026-10-06 11:00")
    )

    refute reservation.valid?
  end

  test "reservation is valid when it starts as another reservation ends" do
    parking_area = ParkingArea.create!(name: "Main parking", capacity: 1)

    existing_reservations = Reservation.create!(
      name: "Jan",
      parking_area: parking_area,
      start_date: Time.zone.parse("2026-10-06 10:00"),
      end_date: Time.zone.parse("2026-10-06 11:00")
    )

    reservation = Reservation.new(
      name: "Petr",
      parking_area: parking_area,
      start_date: Time.zone.parse("2026-10-06 11:00"),
      end_date: Time.zone.parse("2026-10-06 13:00")
    )

    assert reservation.valid?
  end

  test "reservation is valid when capacity is reached but not exceeded" do
    parking_area = ParkingArea.create!(name: "Main parking", capacity: 2)

    existing_reservations = Reservation.create!(
      name: "Jan",
      parking_area: parking_area,
      start_date: Time.zone.parse("2026-10-06 10:00"),
      end_date: Time.zone.parse("2026-10-06 12:00")
    )

    reservation = Reservation.new(
      name: "Petr",
      parking_area: parking_area,
      start_date: Time.zone.parse("2026-10-06 11:00"),
      end_date: Time.zone.parse("2026-10-06 13:00")
    )

    assert reservation.valid?
  end
end
