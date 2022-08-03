class Invoice < ApplicationRecord
  belongs_to :car

  validates :price, numericality: true
end
