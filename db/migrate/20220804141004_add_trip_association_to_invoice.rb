class AddTripAssociationToInvoice < ActiveRecord::Migration[6.0]
  def change
    add_reference :invoices, :trip
  end
end
