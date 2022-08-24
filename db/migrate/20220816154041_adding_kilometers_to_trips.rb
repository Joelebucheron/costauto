class AddingKilometersToTrips < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :kilometers, :integer
    add_column :trips, :start_km, :integer
    add_column :trips, :end_km, :integer
  end
end
