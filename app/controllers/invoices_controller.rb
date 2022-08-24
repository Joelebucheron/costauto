class InvoicesController < ApplicationController

  # FACTURES = ['Entretien', 'Lavage', 'Carburant', 'Péage', 'Mécanique', 'Carosserie', 'Recharge']

  def index
    @car = Car.find(params[:car_id])
    @invoices = Invoice.where(car: @car)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
    @invoice = Invoice.new
    @car = Car.find(params[:format]) unless params[:format].nil?
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to garage_car_invoice_path(@invoice.car, @invoice.car.garage, @invoice)
    else
      render :new
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update(invoice_params)
      redirect_to garage_car_invoice_path(@invoice.car, @invoice.car.garage, @invoice)
    else
      render :edit
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @car = @invoice.car
    @invoice.destroy
    redirect_to garage_car_invoices_path(@invoice.car.garage, @invoice.car)
  end

  private

  def invoice_params
    params.require(:invoice).permit(:name, :supplier, :piece, :price, :kilometers, :date, :car_id, :trip_id)
  end

end
