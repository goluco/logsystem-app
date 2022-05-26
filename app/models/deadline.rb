class Deadline < ApplicationRecord
    belongs_to :carrier
    validates :working_days, :min_distance, :max_distance, :carrier, presence: true
end
