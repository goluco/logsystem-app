require 'rails_helper'

RSpec.describe Deadline, type: :model do
  describe '#valid?' do
    it 'falso quando prazo em dias úteis está vazio' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
      deadline = Deadline.new(working_days: '', min_distance: 0, max_distance: 100, carrier: carrier)
      #Act
      result = deadline.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso quando distância mínima está vazia' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
      deadline = Deadline.new(working_days: 2, min_distance: '', max_distance: 100, carrier: carrier)
      #Act
      result = deadline.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso quando distância máxima está vazia' do
      #Arrange
      carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
      deadline = Deadline.new(working_days: 2, min_distance: 0, max_distance: '', carrier: carrier)
      #Act
      result = deadline.valid?
      #Assert
      expect(result).to eq(false)
    end
  end
end
