require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe "#valid?" do
    it 'falso caso email esteja em branco' do
      #Arrange
      admin_generico = Admin.new(email: '', password: 'password')
      #Act
      result = admin_generico.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso caso senha esteja em branco' do
      #Arrange
      admin_generico = Admin.new(email: 'administrador_generico@sistemadefrete.com', password: '')
      #Act
      result = admin_generico.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso caso email seja diferente do exigido' do
      #Arrange
      admin_generico = Admin.new(email: 'administrador_generico@gmail.com', password: '')
      #Act
      result = admin_generico.valid?
      #Assert
      expect(result).to eq(false)
    end
  end
end
