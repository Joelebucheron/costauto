class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.string :name
      t.integer :kilometers
      t.float :purchased_price
      t.date :purchased_date
      t.float :total_cost

      t.timestamps
    end
  end
end
