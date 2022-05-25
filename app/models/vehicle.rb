class Vehicle < ApplicationRecord
  belongs_to :carrier
  validates :license_plate, :brand, :model, :fabrication_year, :max_capacity, :carrier_id, presence: true
end
