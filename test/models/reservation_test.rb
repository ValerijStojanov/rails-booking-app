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
end
