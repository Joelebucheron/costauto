class Car < ApplicationRecord
  validates :name, :brand, :model, presence: true
  validates :kilometers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :purchased_price, numericality: true
  validates :purchased_date, presence: true

  belongs_to :garage
  has_many :invoices
  has_many :contracts
  has_many :trips

end
