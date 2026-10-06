class Reservation < ApplicationRecord
  belongs_to :parking_area

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :end_date,
          comparison: {
            greater_than: :start_date,
            message: :after_start_date
          }

  validate :capacity_check

  private

  def capacity_check
    return if parking_area.blank? || start_date.blank? || end_date.blank?
    return if end_date <= start_date

    existing_reservations = parking_area.reservations
                                        .where("end_date > ? AND start_date < ?", start_date, end_date)
                                        .where.not(id: id)

    reservations = existing_reservations.to_a + [ self ]

    events = reservations.flat_map do |reservation|
      [
        [ reservation.start_date, 1 ],
        [ reservation.end_date, -1 ]
      ]
    end

    events.sort_by! { |time, change| [ time, change ] }

    sum = 0

    events.each do |_time, change|
      sum += change

      if sum > parking_area.capacity
        errors.add(:base, :capacity_exceeded)
        return
      end
    end
  end
end
