class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.references :car, null: false, foreign_key: true
      t.string :name
      t.string :type
      t.date :date

      t.timestamps
    end
  end
end
