require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'gera um código aleatório' do
    it 'ao gerar uma nova ordem de serviço' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
      order = Order.new(volume: 0.05, product_weight: 5, delivery_address: 'Rua dos Bobos, 0', recipient_name: 'Anselmo Ramos', carrier: carrier, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
      #Act
      order.save!
      result = order.code
      #Assert
      expect(result).not_to be_empty
      expect(result.length).to eq(15)
    end
  end

  describe '#valid?' do
    it 'falso caso volume esteja vazio' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
      order = Order.new(volume: '', product_weight: 5, delivery_address: 'Rua dos Bobos, 0', recipient_name: 'Anselmo Ramos', carrier: carrier, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
      #Act
      result = order.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso caso peso esteja vazio' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
      order = Order.new(volume: 0.05, product_weight: '', delivery_address: 'Rua dos Bobos, 0', recipient_name: 'Anselmo Ramos', carrier: carrier, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
      #Act
      result = order.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso caso endereço esteja vazio' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
      order = Order.new(volume: 0.05, product_weight: 5, delivery_address: '', recipient_name: 'Anselmo Ramos', carrier: carrier, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
      #Act
      result = order.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso caso nome do recebedor esteja vazio' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
      order = Order.new(volume: 0.05, product_weight: 5, delivery_address: 'Rua dos Bobos, 0', recipient_name: '', carrier: carrier, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
      #Act
      result = order.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso caso o código do produto esteja vazio' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
      order = Order.new(volume: 0.05, product_weight: 5, delivery_address: 'Rua dos Bobos, 0', recipient_name: '', carrier: carrier, product_sku: '', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
      #Act
      result = order.valid?
      #Assert
      expect(result).to eq(false)
    end
    
    it 'falso caso o endereço de retirada esteja vazio' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
      order = Order.new(volume: 0.05, product_weight: 5, delivery_address: 'Rua dos Bobos, 0', recipient_name: '', carrier: carrier, product_sku: 'abcde45678', product_address: '', distance: 700)
      #Act
      result = order.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso caso a distância esteja vazia' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
      order = Order.new(volume: 0.05, product_weight: 5, delivery_address: 'Rua dos Bobos, 0', recipient_name: '', carrier: carrier, product_sku: 'abcde45678', product_address: '', distance: '')
      #Act
      result = order.valid?
      #Assert
      expect(result).to eq(false)
    end

  end
end
