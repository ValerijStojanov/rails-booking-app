class Reservation < ApplicationRecord
  belongs_to :room

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
