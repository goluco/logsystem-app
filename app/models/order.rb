class Order < ApplicationRecord
  belongs_to :carrier
  has_one :vehicle
  has_many :infologs
  enum status: { pending_acceptance: 0, accepted: 5, refused: 10, finished: 15 }
  before_validation :set_code
  after_create :set_infolog
  validates :code, uniqueness: true
  validates :volume, :product_weight, :delivery_address, :recipient_name, :carrier_id, :code, :product_sku, :product_address, :distance, presence: true 

  private

  def set_infolog
    infolog = Infolog.create(coordinates: "Ainda sem atualizações", date: "Ainda sem atualizações", time: "Ainda sem atualizações", order_id: self.id)
    self.infolog_id = infolog.id
  end

  def set_code
    if self.code == nil
      self.code = SecureRandom.alphanumeric(15)
    end
  end
end
