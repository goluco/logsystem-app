class Price < ApplicationRecord
    belongs_to :carrier
    has_many :volumes
    has_many :weights
end
