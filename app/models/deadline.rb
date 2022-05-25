class Deadline < ApplicationRecord
    validates :working_days, :min_distance, :max_distance, presence: true
end
