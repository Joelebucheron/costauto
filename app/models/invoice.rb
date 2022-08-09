class Invoice < ApplicationRecord
  belongs_to :car
  belongs_to :trip, optional: true

  validates :price, numericality: true
end
