class ParkingAreasController < ApplicationController
  before_action :set_parking_area, only: :show

  def index
    @parking_areas = ParkingArea.all
  end

  def show
  end

  def new
    @parking_area = ParkingArea.new
  end

  def create
    @parking_area = ParkingArea.new(parking_area_params)

    if @parking_area.save
      redirect_to @parking_area, notice: "Parking area was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_parking_area
    @parking_area = ParkingArea.find(params[:id])
  end

  def parking_area_params
    params.require(:parking_area).permit(:name, :capacity)
  end
end
