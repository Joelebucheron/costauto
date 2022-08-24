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
  end

  def create
    @trip = Trip.new(trip_params)
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

  ### Méthodes de coût ##
  def cost_usable(trip)
    Invoice.where(trip: trip).sum(:price)
  end
  helper_method :cost_usable

  def maintenance_cost(trip)
    if trip.car.kilometers.nil? || trip.kilometers.nil?
      (((Invoice.where(car: trip.car).sum(:price) - cost_usable(trip)) / 1) * 1)
    else
      (((Invoice.where(car: trip.car).sum(:price) - cost_usable(trip)) / trip.car.kilometers) * trip.kilometers)
    end

  end
  helper_method :maintenance_cost

  def total_cost(trip)
    if trip.car.kilometers.nil?
      (((Invoice.where(car: trip.car).sum(:price) + trip.car.purchased_price - cost_usable(trip)) / 1) * trip.kilometers)
    elsif trip.kilometers.nil?
      (((Invoice.where(car: trip.car).sum(:price) + trip.car.purchased_price - cost_usable(trip)) / trip.car.kilometers) * 1)
    else
      (((Invoice.where(car: trip.car).sum(:price) + trip.car.purchased_price - cost_usable(trip)) / trip.car.kilometers) * trip.kilometers)
    end
  end
  helper_method :total_cost

  ## Méthode icone sur la facture ##
  def icons(invoice)
    case invoice.piece
    when 'Entretien'
      'fa-oil-can'
    when 'Lavage'
      'fa-car-wash'
    when 'Carburant'
      'fa-gas-pump'
    when 'Recharge'
      'fa-charging-station'
    when 'Péage'
      'fa-road-lock'
    when 'Mécanique'
      'fa-screwdriver-wrench'
    when 'Carosserie'
      'fa-car-wrench'
    end
  end
  helper_method :icons


  def icons_trip(trip)
    case trip.category
    when 'Professionel'
      "fa-briefcase"
    when 'Travail-Domicile'
      "fa-car-building"
    when 'Vacance'
      "fa-umbrella-beach"
    when 'Personnel'
      "fa-family"
    when 'Autre'
      "fa-question"
    else
      "fa-otter"
    end
  end
  helper_method :icons_trip

  private

  def trip_params
    params.require(:trip).permit(:name, :category, :date, :car_id, :kilometers, :start_km, :end_km, invoice_ids: [])
  end
end
