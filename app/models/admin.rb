class AdminValidator < ActiveModel::Validator 
  def validate(record)
    if record.email.split("@").last != "sistemadefrete.com.br"
      record.errors.add :base, "Cadastro não autorizado para seu e-mail."
    end
  end
end

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_with AdminValidator
end
