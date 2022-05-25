class Weight < ApplicationRecord
    validates :min, :max, presence: true
end
