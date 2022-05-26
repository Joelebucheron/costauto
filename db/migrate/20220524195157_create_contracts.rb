class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :create_contracts do |t|
      t.string :name
      t.string :category
      t.integer :price
      t.date :starting_date
      t.date :ending_date
      t.references :car, foreign_key: true

      t.timestamps
    end
  end
end
