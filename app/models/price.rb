class Price < ApplicationRecord
    belongs_to :carrier
    has_many :volumes
    has_many :weights
    validates :value, :volume_id, :weight_id, :carrier, presence: true
end
