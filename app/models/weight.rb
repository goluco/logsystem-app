class Weight < ApplicationRecord
    validates :name, :min, :max, presence: true
end
