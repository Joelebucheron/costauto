class TripsController < ApplicationController

  def index
    @car = Car.find(params[:car_id])
    @trips = Trip.where(car: @car)
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def new
    @trip = Trip.new
    @car = Car.find(params[:format]) unless params[:format].nil?
    @trip.car = @car
  end

  def create
    @trip = Trip.new(trip_params)
    # @car = Car.find(params[:format]) unless params[:format].nil?
    # @trip.car = @car
    if @trip.save
      redirect_to garage_car_trip_path(@trip.car, @trip.car.garage, @trip)
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update(trip_params)
      redirect_to garage_car_trip_path(@trip.car, @trip.car.garage, @trip)
    else
      render :edit
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    @car = @trip.car
    @trip.destroy
    redirect_to garage_car_trips_path(@car.garage, @car)
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :category, :date, :car_id, :invoice_id)
  end
end
