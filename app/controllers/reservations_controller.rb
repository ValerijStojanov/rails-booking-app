class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update ]

  def index
    @reservations = Reservation.all
  end

  def show
  end

  def new
    @reservation = Reservation.new
    @parking_areas = ParkingArea.all
    @reservation.parking_area_id = params[:parking_area_id]
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to @reservation, notice: "Reservation was successfully created."
    else
      @parking_areas = ParkingArea.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @parking_areas = ParkingArea.all
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to @reservation, notice: "Reservation was successfully updated."
    else
      @parking_areas = ParkingArea.all
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:name, :parking_area_id, :start_date, :end_date)
  end
end
