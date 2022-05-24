class UserValidator < ActiveModel::Validator 
  def validate(record)
    if record.email.split("@").last != record.carrier.domain.split("@").last
      record.errors.add :base, "Cadastro não autorizado para seu e-mail."
    end
  end
end

class User < ApplicationRecord
  belongs_to :carrier
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :carrier_id, presence: true
  validates_with UserValidator
end
