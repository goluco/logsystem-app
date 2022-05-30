require 'rails_helper'

describe 'Admin cria pedido para uma transportadora ativa' do
    it 'a partir da tela inicial' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Gerenciar ordens de serviço'
        #Assert
        expect(page).to have_link('Criar nova ordem de serviço')
        expect(page).to have_content('Pedidos aguardando aceite')
        expect(page).to have_content('Pedidos aceitos e a caminho')
        expect(page).to have_content('Pedidos recusados')
    end

    it 'com sucesso' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        first_carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        second_carrier = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 23456789012345, address: 'Rua Scuvero, 282', city: 'São Paulo', state: 'SP')
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Gerenciar ordens de serviço'
        click_on 'Criar nova ordem de serviço'
        fill_in 'Volume do produto (em m³)', with: 0.015
        fill_in 'Peso do produto (em kg)', with: 14
        fill_in 'Endereço de retirada do produto', with: 'Rua dos Malandros, 97, Sao Tomé - RJ'
        fill_in 'Código do produto', with: 'ASHU2794YTRE'
        fill_in 'Endereço de entrega', with: 'Rua dos Inocentes, 42'
        fill_in 'Distância', with: 700
        fill_in 'Nome do destinatário', with: 'Anselmo Ramon'
        select 'TTLog', from: 'Transportadora'
        click_on 'Enviar'
        #Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Pedido realizado com sucesso')  
    end

    it 'com dados incompletos' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        first_carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        second_carrier = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 23456789012345, address: 'Rua Scuvero, 282', city: 'São Paulo', state: 'SP')
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Gerenciar ordens de serviço'
        click_on 'Criar nova ordem de serviço'
        fill_in 'Volume do produto (em m³)', with: ''
        fill_in 'Peso do produto (em kg)', with: ''
        fill_in 'Endereço de retirada do produto', with: 'Rua dos Malandros, 97, Sao Tomé - RJ'
        fill_in 'Código do produto', with: 'ASHU2794YTRE'
        fill_in 'Endereço de entrega', with: 'Rua dos Inocentes, 42'
        fill_in 'Distância', with: 700
        fill_in 'Nome do destinatário', with: 'Anselmo Ramon'
        select 'TTLog', from: 'Transportadora'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Pedido não realizado. Revisar os campos')
        expect(page).to have_content('Volume do produto (em m³) não pode ficar em branco')
        expect(page).to have_content('Peso do produto (em kg) não pode ficar em branco')
    end

    it 'em uma transportadora que não possui condição de fazer a entrega' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        first_carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        first_volume = Volume.create!(name: '0.001 a 0.005', min: 0.001, max: 0.005)
        second_volume = Volume.create!(name: '0.006 a 0.01', min: 0.006, max: 0.01)
        third_volume = Volume.create!(name: '0.02 a 0.05', min: 0.02, max: 0.05)
        first_weight = Weight.create!(name: '0 a 10', min: 0, max: 10)
        second_weight = Weight.create!(name: '11 a 20', min: 11, max: 20)
        third_weight = Weight.create!(name: '21 a 30', min: 21, max: 30)
        first_deadline_first_carrier = Deadline.create!(working_days: 2, min_distance: 0, max_distance: 100, carrier: first_carrier)
        second_deadline_first_carrier = Deadline.create!(working_days: 4, min_distance: 101, max_distance: 400, carrier: first_carrier)
        third_deadline_first_carrier = Deadline.create!(working_days: 7, min_distance: 401, max_distance: 700, carrier: first_carrier)
        first_price_first_carrier = Price.create!(value: 0.6, volume_id: first_volume.id, weight_id: first_weight.id, carrier: first_carrier)
        second_price_first_carrier = Price.create!(value: 0.8, volume_id: second_volume.id, weight_id: second_weight.id, carrier: first_carrier)
        third_price_first_carrier = Price.create!(value: 1.0, volume_id: third_volume.id, weight_id: third_weight.id, carrier: first_carrier)
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Gerenciar ordens de serviço'
        click_on 'Criar nova ordem de serviço'
        fill_in 'Volume do produto (em m³)', with: 0.06
        fill_in 'Peso do produto (em kg)', with: 31
        fill_in 'Endereço de retirada do produto', with: 'Rua dos Malandros, 97, Sao Tomé - RJ'
        fill_in 'Código do produto', with: 'ASHU2794YTRE'
        fill_in 'Endereço de entrega', with: 'Rua dos Inocentes, 42'
        fill_in 'Nome do destinatário', with: 'Anselmo Ramon'
        fill_in 'Distância', with: 700
        select 'TTLog', from: 'Transportadora'
        click_on 'Enviar'
        #Assert
    end
end