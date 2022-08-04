class Trip < ApplicationRecord
  belongs_to :car

  validates :name, :type, presence: true
end
