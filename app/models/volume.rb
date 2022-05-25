class Volume < ApplicationRecord
    validates :name, :min, :max, presence: true
end
