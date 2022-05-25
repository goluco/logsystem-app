class Volume < ApplicationRecord
    validates :min, :max, presence: true
end
