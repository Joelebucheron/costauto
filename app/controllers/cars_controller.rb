class CarsController < ApplicationController
  require 'date'
  include ActionView::Helpers::DateHelper

  def index
    @cars = Car.all
  end

  def show
    find
    @garage = Garage.find(params[:garage_id])
  end

  def new
    @car = Car.new
    @garage = Garage.find(params[:garage_id])
  end

  def create
    @car = Car.new(car_params)
    @car.garage = Garage.find(params[:garage_id])

    if @car.save
      redirect_to garage_car_path(@car.garage, @car)
    else
      render :new
    end
  end

  def edit
    find
  end

  def update
    find
    if @car.update(car_params)
      redirect_to garage_car_path(@car.garage, @car)
    else
      render :edit
    end
  end

  def destroy
    find
    @garage = @car.garage
    @car.destroy
    redirect_to garage_path(@garage)
  end

############# Methode de Temps ###############
  def ownership_time(car)
    distance_of_time_in_words(Date.current, car.purchased_date)
  end
  helper_method :ownership_time

  def car_ownership(car)
    result = (car.purchased_date - Date.today).abs / 365
    result.to_i / 1
  end
  helper_method :car_ownership

  def distance_of_time_in(unit, from, to)
    diff = to - from

    if 1.respond_to? unit
      distance = diff / 1.send(unit)
      distance.abs.round
    else
      raise ArgumentError, "#{unit.inspect} is not supported as unit"
    end
  end
  helper_method :distance_of_time_in
##################################################

  def ownership_cost(car)
    (Invoice.where(car: car, piece: 'Entretien').sum(:price) + car.purchased_price)
  end
  helper_method :ownership_cost

  private

  def car_params
    params.require(:car).permit(:name, :brand, :model, :kilometers, :purchased_date, :purchased_price)
  end

  def find
    @car = Car.find(params[:id])
  end

end
