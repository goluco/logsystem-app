require 'rails_helper'

describe 'Admin cria pedido para uma transportadora ativa' do
    it 'a partir da tela inicial' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        first_carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        second_carrier = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 23456789012345, address: 'Rua Scuvero, 282', city: 'São Paulo', state: 'SP')
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
        fill_in 'Endereço de entrega', with: 'Rua dos Inocentes, 42'
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
         fill_in 'Endereço de entrega', with: 'Rua dos Inocentes, 42'
         fill_in 'Nome do destinatário', with: 'Anselmo Ramon'
         select 'TTLog', from: 'Transportadora'
         click_on 'Enviar'
         #Assert
         expect(page).to have_content('Pedido não realizado. Revisar os campos')
         expect(page).to have_content('Volume do produto (em m³) não pode ficar em branco')
         expect(page).to have_content('Peso do produto (em kg) não pode ficar em branco')
    end
end