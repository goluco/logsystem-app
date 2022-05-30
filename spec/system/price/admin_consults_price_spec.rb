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
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Gerenciar orçamentos'
        #Assert
        expect(page).to have_content('Orçamento de entrega. Preencha os campos abaixo')
        expect(page).to have_field('Peso do Produto (em Kg)')
        expect(page).to have_field('Altura do Produto (em m)')
        expect(page).to have_field('Largura do Produto (em m)')
        expect(page).to have_field('Profundidade do Produto (em m)')
        expect(page).to have_field('Distância a ser percorrida (em km)')
        expect(page).to have_button('Enviar')
    end

    it 'com sucesso' do
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
         first_deadline_first_carrier = Deadline.create!(working_days: 2, min_distance: 0, max_distance: 100, carrier: first_carrier)
         second_deadline_first_carrier = Deadline.create!(working_days: 4, min_distance: 101, max_distance: 400, carrier: first_carrier)
         third_deadline_first_carrier = Deadline.create!(working_days: 7, min_distance: 401, max_distance: 700, carrier: first_carrier)
         first_deadline_second_carrier = Deadline.create!(working_days: 3, min_distance: 0, max_distance: 100, carrier: second_carrier)
         second_deadline_second_carrier = Deadline.create!(working_days: 5, min_distance: 101, max_distance: 400, carrier: second_carrier)
         third_deadline_second_carrier = Deadline.create!(working_days: 8, min_distance: 401, max_distance: 700, carrier: second_carrier)
         first_price_first_carrier = Price.create!(value: 0.6, volume_id: first_volume.id, weight_id: first_weight.id, carrier: first_carrier)
         second_price_first_carrier = Price.create!(value: 0.8, volume_id: second_volume.id, weight_id: second_weight.id, carrier: first_carrier)
         third_price_first_carrier = Price.create!(value: 1.0, volume_id: third_volume.id, weight_id: third_weight.id, carrier: first_carrier)
         first_price_second_carrier = Price.create!(value: 0.6, volume_id: first_volume.id, weight_id: first_weight.id, carrier: second_carrier)
         second_price_second_carrier = Price.create!(value: 0.5, volume_id: second_volume.id, weight_id: second_weight.id, carrier: second_carrier)
         third_price_second_carrier = Price.create!(value: 0.6, volume_id: third_volume.id, weight_id: third_weight.id, carrier: second_carrier)
         #Act
         login_as(admin_gen, scope: :admin)
         visit root_path
         click_on 'Gerenciar orçamentos'
         fill_in 'Peso do Produto (em Kg)', with: 15
         fill_in 'Altura do Produto (em m)', with: 1
         fill_in 'Largura do Produto (em m)', with: 0.5
         fill_in 'Profundidade do Produto (em m)', with: 0.02
         fill_in 'Distância a ser percorrida (em km)', with: 200
         click_on 'Enviar'
         #Assert
         expect(current_path).to eq(search_prices_path)
         expect(page).to have_content('Transportadora: TTLog | Preço: R$160.0 | Prazo: 4 dias úteis')
         expect(page).to have_content('Transportadora: ARLog | Preço: R$100.0 | Prazo: 5 dias úteis')
    end

    it 'e nenhuma transportadora pode realizar a entrega' do
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
         first_deadline_first_carrier = Deadline.create!(working_days: 2, min_distance: 0, max_distance: 100, carrier: first_carrier)
         second_deadline_first_carrier = Deadline.create!(working_days: 4, min_distance: 101, max_distance: 400, carrier: first_carrier)
         third_deadline_first_carrier = Deadline.create!(working_days: 7, min_distance: 401, max_distance: 700, carrier: first_carrier)
         first_deadline_second_carrier = Deadline.create!(working_days: 3, min_distance: 0, max_distance: 100, carrier: second_carrier)
         second_deadline_second_carrier = Deadline.create!(working_days: 5, min_distance: 101, max_distance: 400, carrier: second_carrier)
         third_deadline_second_carrier = Deadline.create!(working_days: 8, min_distance: 401, max_distance: 700, carrier: second_carrier)
         first_price_first_carrier = Price.create!(value: 0.6, volume_id: first_volume.id, weight_id: first_weight.id, carrier: first_carrier)
         second_price_first_carrier = Price.create!(value: 0.8, volume_id: second_volume.id, weight_id: second_weight.id, carrier: first_carrier)
         third_price_first_carrier = Price.create!(value: 1.0, volume_id: third_volume.id, weight_id: third_weight.id, carrier: first_carrier)
         first_price_second_carrier = Price.create!(value: 0.6, volume_id: first_volume.id, weight_id: first_weight.id, carrier: second_carrier)
         second_price_second_carrier = Price.create!(value: 0.5, volume_id: second_volume.id, weight_id: second_weight.id, carrier: second_carrier)
         third_price_second_carrier = Price.create!(value: 0.6, volume_id: third_volume.id, weight_id: third_weight.id, carrier: second_carrier)
         #Act
         login_as(admin_gen, scope: :admin)
         visit root_path
         click_on 'Gerenciar orçamentos'
         fill_in 'Peso do Produto (em Kg)', with: 35
         fill_in 'Altura do Produto (em m)', with: 1
         fill_in 'Largura do Produto (em m)', with: 0.5
         fill_in 'Profundidade do Produto (em m)', with: 0.02
         fill_in 'Distância a ser percorrida (em km)', with: 200
         click_on 'Enviar'
         #Assert
         expect(current_path).to eq(search_prices_path)
         expect(page).to have_content('Não existem transportadoras ativas para realizar este frete.')
    end

    it 'e visualiza os orçamentos realizados anteriormente' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        first_carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        second_carrier = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 23456789012345, address: 'Rua Scuvero, 282', city: 'São Paulo', state: 'SP')
        budget_one = Budget.create!(carrier: first_carrier, value: 120.0, deadline: 5)
        budget_two = Budget.create!(carrier: first_carrier, value: 150.0, deadline: 3)
        budget_three = Budget.create!(carrier: second_carrier, value: 190.0, deadline: 4)
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Gerenciar orçamentos'
        #Assert
        expect(page).to have_content('Orçamentos anteriores')
        expect(page).to have_link('TTLog | R$ 120.0 | 5 dias úteis')
        expect(page).to have_link('TTLog | R$ 150.0 | 3 dias úteis')
        expect(page).to have_link('ARLog | R$ 190.0 | 4 dias úteis')
    end
end