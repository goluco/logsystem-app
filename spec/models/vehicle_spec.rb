require 'rails_helper'

RSpec.describe Vehicle, type: :model do
    describe '#valid?' do
        it 'falso quando placa de identificação está vazia' do
            #Arrange
            carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
            vehicle = Vehicle.new(license_plate: '', brand: 'Ford', model: 'Ford Truck Road', fabrication_year: 2018, max_capacity: 12, carrier: carrier)
            #Act
            result = vehicle.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando marca está vazia' do
            #Arrange
            carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
            vehicle = Vehicle.new(license_plate: 'CBU1711', brand: '', model: 'Ford Truck Road', fabrication_year: 2018, max_capacity: 12, carrier: carrier)
            #Act
            result = vehicle.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando modelo está vazio' do
            #Arrange
            carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
            vehicle = Vehicle.new(license_plate: '', brand: 'Ford', model: '', fabrication_year: 2018, max_capacity: 12, carrier: carrier)
            #Act
            result = vehicle.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando ano de fabricação está vazio' do
            #Arrange
            carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
            vehicle = Vehicle.new(license_plate: '', brand: 'Ford', model: 'Ford Truck Road', fabrication_year: '', max_capacity: 12, carrier: carrier)
            #Act
            result = vehicle.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando capacidade máxima está vazia' do
            #Arrange
            carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
            vehicle = Vehicle.new(license_plate: '', brand: 'Ford', model: 'Ford Truck Road', fabrication_year: 2018, max_capacity: '', carrier: carrier)
            #Act
            result = vehicle.valid?
            #Assert
            expect(result).to eq(false)
        end
    end
end
