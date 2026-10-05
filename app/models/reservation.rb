class Reservation < ApplicationRecord
  belongs_to :parking_area

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :end_date, comparison:  { greater_than: :start_date }
end
