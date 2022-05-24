class Vehicle < ApplicationRecord
  belongs_to :carrier
  validates :license_plate, :brand, :model, :fabrication_year, :max_capacity, :carrier, presence: true
end
