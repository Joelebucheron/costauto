class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.string :name
      t.string :supplier
      t.string :piece
      t.float :price
      t.integer :kilometers
      t.date :date
      t.references :car, foreign_key: true

      t.timestamps
    end
  end
end
