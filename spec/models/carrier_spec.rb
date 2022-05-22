require 'rails_helper'

RSpec.describe Carrier, type: :model do
    describe '#valid?' do
        it 'falso caso nome fantasia esteja vazio' do
            #Arrange
            carrier = Carrier.new(trade_name: '', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 12345678901234, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso razão social esteja vazio' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: '', domain: '@arlog.com.br', nif: 12345678901234, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso domínio esteja vazio' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '', nif: 12345678901234, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso CNPJ esteja vazio' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: '', address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso endereço esteja vazio' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 12345678901234, address: '', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso cidade esteja vazia' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 12345678901234, address: 'Avenida Brasil, 5523', city: '', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso estado esteja vazio' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 12345678901234, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: '')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso haja caracteres não numéricos no CNPJ' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: '1234567890abcd', address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso cnpj tenha um número diferente de 14 caracteres' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 123456789012345, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso cnpj seja repetido' do
            #Arrange
            carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
            carrier2 = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 12345678901234, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier2.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso domínio esteja no formato incorreto' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com', nif: 12345678901234, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso domínio esteja no formato incorreto' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: 'arlog.com.br', nif: 12345678901234, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso domínio esteja no formato incorreto' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.br', nif: 12345678901234, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso caso domínio esteja no formato incorreto' do
            #Arrange
            carrier = Carrier.new(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: 'qualquerdominio', nif: 12345678901234, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
            #Act
            result = carrier.valid?
            #Assert
            expect(result).to eq(false)
        end
    end
end
