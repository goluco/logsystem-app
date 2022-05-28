require 'rails_helper'

describe 'Usuário recebe pedido para entrega' do
    it 'a partir da página inicial' do
        #Arrange
        admin = Admin.create!(email: 'darth@sistemadefrete.com.br', password: 'iamyourfather')
        carrier = Carrier.create!(trade_name: 'DSLog', corporate_name: 'Death Star Log', domain: '@dslog.com.br', nif: 45678901234567, address: 'Canto da Galáxia, 1990', city: 'Death Star', state: 'VC')
        user = User.create!(name: "Luke Skywalker", email: "lukeskyson@dslog.com.br", password: 'unlikemyfather', carrier: carrier)
        #Act
        login_as(admin)
        Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier)
        logout(:admin)
        login_as(user)
        visit root_path
        click_on 'Visualizar pedidos'
        #Assert
        expect(page).to have_content('Pedido para: Largo das Neves, 500 | Arya Stark')
        expect(page).to have_link('Ver detalhes')
    end

    it 'e visualiza os detalhes do pedido' do
        #Arrange
        admin = Admin.create!(email: 'darth@sistemadefrete.com.br', password: 'iamyourfather')
        carrier = Carrier.create!(trade_name: 'DSLog', corporate_name: 'Death Star Log', domain: '@dslog.com.br', nif: 45678901234567, address: 'Canto da Galáxia, 1990', city: 'Death Star', state: 'VC')
        user = User.create!(name: "Luke Skywalker", email: "lukeskyson@dslog.com.br", password: 'unlikemyfather', carrier: carrier)
        #Act
        login_as(admin)
        Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier)
        logout(:admin)
        login_as(user)
        visit root_path
        click_on 'Visualizar pedidos'
        click_on 'Ver detalhes'
        #Assert
        expect(page).to have_content('Volume: 0.015m³')
        expect(page).to have_content('Peso do produto: 15kg')
        expect(page).to have_content('Endereço de entrega: Largo das Neves, 500')
        expect(page).to have_content('Nome do destinatário: Arya Stark')
        expect(page).to have_button('Aceitar pedido')
        expect(page).to have_button('Recusar pedido')
    end

    it 'e aceita o pedido' do
         #Arrange
         admin = Admin.create!(email: 'darth@sistemadefrete.com.br', password: 'iamyourfather')
         carrier = Carrier.create!(trade_name: 'DSLog', corporate_name: 'Death Star Log', domain: '@dslog.com.br', nif: 45678901234567, address: 'Canto da Galáxia, 1990', city: 'Death Star', state: 'VC')
         user = User.create!(name: "Luke Skywalker", email: "lukeskyson@dslog.com.br", password: 'unlikemyfather', carrier: carrier)
         #Act
         login_as(admin)
         Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier)
         logout(:admin)
         login_as(user)
         visit root_path
         click_on 'Visualizar pedidos'
         click_on 'Ver detalhes'
         click_on 'Aceitar pedido'
         #Assert
         expect(page).to have_content('Volume: 0.015m³')
         expect(page).to have_content('Peso do produto: 15kg')
         expect(page).to have_content('Endereço de entrega: Largo das Neves, 500')
         expect(page).to have_content('Nome do destinatário: Arya Stark')
         expect(page).to have_content('Status: Pedido aceito')
         expect(page).to have_button('Finalizar pedido')
    end

    it 'e recusa o pedido' do
        #Arrange
        admin = Admin.create!(email: 'darth@sistemadefrete.com.br', password: 'iamyourfather')
        carrier = Carrier.create!(trade_name: 'DSLog', corporate_name: 'Death Star Log', domain: '@dslog.com.br', nif: 45678901234567, address: 'Canto da Galáxia, 1990', city: 'Death Star', state: 'VC')
        user = User.create!(name: "Luke Skywalker", email: "lukeskyson@dslog.com.br", password: 'unlikemyfather', carrier: carrier)
        #Act
        login_as(admin)
        Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier)
        logout(:admin)
        login_as(user)
        visit root_path
        click_on 'Visualizar pedidos'
        click_on 'Ver detalhes'
        click_on 'Recusar pedido'
        #Assert
        expect(page).to have_content('Volume: 0.015m³')
        expect(page).to have_content('Peso do produto: 15kg')
        expect(page).to have_content('Endereço de entrega: Largo das Neves, 500')
        expect(page).to have_content('Nome do destinatário: Arya Stark')
        expect(page).to have_content('Status: Pedido recusado')
    end

    it 'e finaliza a entrega' do
         #Arrange
         admin = Admin.create!(email: 'darth@sistemadefrete.com.br', password: 'iamyourfather')
         carrier = Carrier.create!(trade_name: 'DSLog', corporate_name: 'Death Star Log', domain: '@dslog.com.br', nif: 45678901234567, address: 'Canto da Galáxia, 1990', city: 'Death Star', state: 'VC')
         user = User.create!(name: "Luke Skywalker", email: "lukeskyson@dslog.com.br", password: 'unlikemyfather', carrier: carrier)
         #Act
         login_as(admin)
         Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier, status: 5)
         logout(:admin)
         login_as(user)
         visit root_path
         click_on 'Visualizar pedidos'
         click_on 'Ver detalhes'
         click_on 'Finalizar pedido'
         #Assert
         expect(page).to have_content('Volume: 0.015m³')
         expect(page).to have_content('Peso do produto: 15kg')
         expect(page).to have_content('Endereço de entrega: Largo das Neves, 500')
         expect(page).to have_content('Nome do destinatário: Arya Stark')
         expect(page).to have_content('Status: Pedido entregue e finalizado')
    end
end