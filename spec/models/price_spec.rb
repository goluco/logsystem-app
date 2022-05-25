require 'rails_helper'

RSpec.describe Price, type: :model do
    describe '#valid?' do
        it 'falso quando valor está vazio' do
            #Arrange
            carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
            volume = Volume.create!(name: '0.001 a 0.005', min: 0.001, max: 0.005)
            weight = Weight.create!(name: '0 a 10', min: 0, max: 10)
            price = Price.new(value: '', volume_id: volume.id, weight_id: weight.id, carrier: carrier)
            #Act
            result = price.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando volume está vazio' do
            #Arrange
            carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
            volume = Volume.create!(name: '0.001 a 0.005', min: 0.001, max: 0.005)
            weight = Weight.create!(name: '0 a 10', min: 0, max: 10)
            price = Price.new(value: 1, volume_id: '', weight_id: weight.id, carrier: carrier)
            #Act
            result = price.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando peso está vazio' do
           #Arrange
           carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
           volume = Volume.create!(name: '0.001 a 0.005', min: 0.001, max: 0.005)
           weight = Weight.create!(name: '0 a 10', min: 0, max: 10)
           price = Price.new(value: 1, volume_id: volume.id, weight_id: '', carrier: carrier)
           #Act
           result = price.valid?
           #Assert
           expect(result).to eq(false)
        end
    end
end
