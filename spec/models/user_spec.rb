require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid?" do
    it 'falso caso email esteja em branco' do
      #Arrange
      usuario_generico = User.new(email: '', password: 'password')
      #Act
      result = usuario_generico.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso caso senha esteja em branco' do
      #Arrange
      usuario_generico = User.new(email: 'usuariogenerico@transportadoragenerica', password: '')
      #Act
      result = usuario_generico.valid?
      #Assert
      expect(result).to eq(false)
    end
  end
end
