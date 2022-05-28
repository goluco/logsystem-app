class Order < ApplicationRecord
  belongs_to :carrier
  enum status: { pending_acceptance: 0, accepted: 5, refused: 10, finished: 15 }
  before_validation :set_code
  validates :code, uniqueness: true
  validates :volume, :product_weight, :delivery_address, :recipient_name, :carrier_id, :code, presence: true

  private

  def set_code
    self.code = SecureRandom.alphanumeric(15)
  end
end
