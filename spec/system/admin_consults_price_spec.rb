require 'rails_helper'

describe 'Administrador faz orçamento' do
    it 'a partir da tela inicial' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        first_carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        second_carrier = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 23456789012345, address: 'Rua Scuvero, 282', city: 'São Paulo', state: 'SP')
        first_volume = Volume.create!(name: '0.001 a 0.005', min: 0.001, max: 0.005)
        second_volume = Volume.create!(name: '0.006 a 0.01', min: 0.006, max: 0.01)
        third_volume = Volume.create!(name: '0.02 a 0.05', min: 0.02, max: 0.05)
        first_weight = Weight.create!(name: '0 a 10', min: 0, max: 10)
        second_weight = Weight.create!(name: '11 a 20', min: 11, max: 20)
        third_weight = Weight.create!(name: '21 a 30', min: 21, max: 30)
        first_price_first_carrier = Price.create!(value: 0.6, volume_id: first_volume.id, weight_id: first_weight.id, carrier: first_carrier)
        second_price_first_carrier = Price.create!(value: 0.8, volume_id: second_volume.id, weight_id: second_weight.id, carrier: first_carrier)
        third_price_first_carrier = Price.create!(value: 1.0, volume_id: third_volume.id, weight_id: third_weight.id, carrier: first_carrier)
        first_price_second_carrier = Price.create!(value: 0.6, volume_id: first_volume.id, weight_id: first_weight.id, carrier: second_carrier)
        second_price_second_carrier = Price.create!(value: 0.5, volume_id: second_volume.id, weight_id: second_weight.id, carrier: second_carrier)
        third_price_second_carrier = Price.create!(value: 0.6, volume_id: third_volume.id, weight_id: third_weight.id, carrier: second_carrier)
        #Act
        visit root_path
        click_on 'Fazer orçamento de entrega'
        #Assert
        expect(page).to have_content('Cálculo de orçamento. Preencha os dados abaixo')
        expect(page).to have_field('Volume do Item em m³')
        expect(page).to have_field('Peso do Item em kg')
        expect(page).to have_field('Distância em km')
    end
end