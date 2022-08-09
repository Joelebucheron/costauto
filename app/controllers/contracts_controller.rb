class ContractsController < ApplicationController

  def index
    @car = Car.find(params[:car_id])
    @contracts = Contract.where(car: @car)
  end

  def show
    @contract = Contract.find(params[:id])
  end

  def new
    @contract = Contract.new
    @car = Car.find(params[:format]) unless params[:format].nil?
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      redirect_to garage_car_contract_path(@contract.car, @contract.car.garage, @contract)
    else
      render :new
    end
  end

  def edit
    @contract = Contract.find(params[:id])
  end

  def update
    @contract = Contract.find(params[:id])
    if @contract.update(contract_params)
      redirect_to garage_car_contract_path(@contract.car, @contract.car.garage, @contract)
    else
      render :edit
    end
  end

  def destroy
    @contract = Contract.find(params[:id])
    @car = @contract.car
    @contract.destroy
    redirect_to garage_car_contracts_path(@contract.car.garage, @contract.car)
  end

  private

  def contract_params
    params.require(:contract).permit(:name, :category, :price, :starting_date, :ending_date, :car_id)
  end


end
