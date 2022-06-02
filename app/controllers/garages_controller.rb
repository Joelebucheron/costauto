class GaragesController < ApplicationController

  def index
    @garages = Garage.all
  end

  def show
    find
    @cars = Car.where(garage: @garage)
  end

  def new
    @garage = Garage.new
  end

  def create
    @garage = Garage.new(garage_params)
    @garage.user = current_user
    if @garage.save
      redirect_to garage_path(@garage)
    else
      render :new
    end
  end

  def edit
    @garage = Garage.find(params[:id])
  end

  def update
    find
    if @garage.update(garage_params)
      redirect_to garage_path(@garage)
    else
      render :edit
    end
  end

  def destroy
    find
    @garage.destroy
    redirect_to garages_path
  end

  private

  def garage_params
    params.require(:garage).permit(:name)
  end

  def find
    @garage = Garage.find(params[:id])
  end
end
