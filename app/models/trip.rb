class Trip < ApplicationRecord
  belongs_to :car
  has_many :invoices

  validates :name, presence: true
end
