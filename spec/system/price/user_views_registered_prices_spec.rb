require 'rails_helper'

describe 'Usuário visualiza preços registrados' do
    it 'visualiza todas as taxas cadastradas' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        volume = Volume.create!(name: '0.001 a 0.005', min: 0.001, max: 0.005)
        weight = Weight.create!(name: '0 a 10', min: 0, max: 10)
        volume2 = Volume.create!(name: '0.005 a 0.01', min: 0.005, max: 0.01)
        weight2 = Weight.create!(name: '10 a 20', min: 10, max: 20)
        price = Price.create!(value: 0.5, volume_id: volume.id, weight_id: weight.id, carrier: carrier)
        price2 = Price.create!(value: 1, volume_id: volume2.id, weight_id: weight2.id, carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        #Assert
        expect(page).to have_content('Preço: R$0.5 por KM | Volume: 0.001 a 0.005 | Peso: 0 a 10KG')
        expect(page).to have_content('Preço: R$1.0 por KM | Volume: 0.005 a 0.01 | Peso: 10 a 20KG')
    end

    it 'e não existem taxas cadastradas' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        #Assert
        expect(page).to have_content('Não existem preços cadastrados.')
    end

    it 'e não vê os preços cadastrados por outras transportadoras' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        volume = Volume.create!(name: '0.001 a 0.005', min: 0.001, max: 0.005)
        weight = Weight.create!(name: '0 a 10', min: 0, max: 10)
        volume2 = Volume.create!(name: '0.005 a 0.01', min: 0.005, max: 0.01)
        weight2 = Weight.create!(name: '10 a 20', min: 10, max: 20)
        price = Price.create!(value: 0.5, volume_id: volume.id, weight_id: weight.id, carrier: carrier)
        price2 = Price.create!(value: 1, volume_id: volume2.id, weight_id: weight2.id, carrier: carrier)
        carrier2 = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 23456789012345, address: 'Rua Inexistente, 1500', city: 'Citrolândia', state: 'AZ')
        volume3 = Volume.create!(name: '0.003 a 0.01', min: 0.003, max: 0.01)
        weight3 = Weight.create!(name: '40 a 100', min: 40, max: 100)
        price3 = Price.create!(value: 2, volume_id: volume3.id, weight_id: weight3.id, carrier: carrier2)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        #Assert
        expect(page).to have_content('Preço: R$0.5 por KM | Volume: 0.001 a 0.005 | Peso: 0 a 10KG')
        expect(page).to have_content('Preço: R$1.0 por KM | Volume: 0.005 a 0.01 | Peso: 10 a 20KG')
        expect(page).not_to have_content('Preço: R$2.0 por KM | Volume: 0.003 a 0.001 | Peso: 40 a 100KG')
    end
end