require 'rails_helper'

describe 'Admin visualiza todos os pedidos' do
    it 'Pendentes' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        first_carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        second_carrier = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 23456789012345, address: 'Rua Scuvero, 282', city: 'São Paulo', state: 'SP')
        Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: first_carrier, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Gerenciar ordens de serviço'
        #Assert
        expect(page).to have_content('Pedido para: Largo das Neves, 500 | Arya Stark | TTLog')
    end

    it 'Aceitos' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        first_carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        second_carrier = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 23456789012345, address: 'Rua Scuvero, 282', city: 'São Paulo', state: 'SP')
        Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: first_carrier, status: 5, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Gerenciar ordens de serviço'
        #Assert
        expect(page).to have_content('Pedido para: Largo das Neves, 500 | Arya Stark | TTLog')
    end

    it 'Recusados' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        first_carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        second_carrier = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 23456789012345, address: 'Rua Scuvero, 282', city: 'São Paulo', state: 'SP')
        Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: first_carrier, status: 10, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Gerenciar ordens de serviço'
        #Assert
        expect(page).to have_content('Pedido para: Largo das Neves, 500 | Arya Stark | TTLog')
    end

    it 'Finalizados' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        first_carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        second_carrier = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 23456789012345, address: 'Rua Scuvero, 282', city: 'São Paulo', state: 'SP')
        Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: first_carrier, status: 15, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Gerenciar ordens de serviço'
        #Assert
        expect(page).to have_content('Pedido para: Largo das Neves, 500 | Arya Stark | TTLog')
    end
end