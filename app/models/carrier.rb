class Carrier < ApplicationRecord
    enum status: { active: 0, inactive: 2 }
    validates :trade_name, :corporate_name, :domain, :nif, :address, :city, :state, presence: true
    validates :domain, format: { with:  /\A@[a-zA-Z]+\.com\.br\z/ }
    validates :nif, numericality: true
    validates :nif, length: { is: 14 }
    validates :nif, uniqueness: true
    has_many :prices
end
