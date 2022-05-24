require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#valid?" do
    it 'falso caso email esteja em branco' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'Transportadora Genérica', corporate_name: 'Nome genérico', domain: '@transportadoragenerica.com.br', nif: 12345678901234, address: 'Rua Genérica, 100', city: 'Cidade Genérica', state: 'EG')
      usuario_generico = User.new(name: 'Usuario Generico', email: '', password: 'password', carrier: carrier)
      #Act
      result = usuario_generico.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso caso senha esteja em branco' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'Transportadora Genérica', corporate_name: 'Nome genérico', domain: '@transportadoragenerica.com.br', nif: 12345678901234, address: 'Rua Genérica, 100', city: 'Cidade Genérica', state: 'EG')
      usuario_generico = User.new(name: 'Usuario genérico', email: 'usuariogenerico@transportadoragenerica.com.br', password: '', carrier: carrier)
      #Act
      result = usuario_generico.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso caso nome esteja em branco' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'Transportadora Genérica', corporate_name: 'Nome genérico', domain: '@transportadoragenerica.com.br', nif: 12345678901234, address: 'Rua Genérica, 100', city: 'Cidade Genérica', state: 'EG')
      usuario_generico = User.new(name: '', email: 'usuariogenerico@transportadoragenerica.com.br', password: 'password', carrier: carrier)
      #Act
      result = usuario_generico.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso caso domínio do email seja diferente do domínio da transportadora' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'Transportadora Genérica', corporate_name: 'Nome genérico', domain: '@transportadoragenerica.com.br', nif: 12345678901234, address: 'Rua Genérica, 100', city: 'Cidade Genérica', state: 'EG')
      usuario_generico = User.new(name: 'Usuário Genérico', email: 'usuariogenerico@umaoutratransportadoragenerica.com.br', password: 'password', carrier: carrier)
      #Act
      result = usuario_generico.valid?
      #Assert
      expect(result).to eq(false)
    end
  end
end
