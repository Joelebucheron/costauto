class Invoice < ApplicationRecord
  belongs_to :car
  belongs_to :trip

  validates :price, numericality: true
end
