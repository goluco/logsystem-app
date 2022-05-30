require 'rails_helper'

describe 'Usuário recebe pedido para entrega' do
    it 'a partir da página inicial' do
        #Arrange
        admin = Admin.create!(email: 'darth@sistemadefrete.com.br', password: 'iamyourfather')
        carrier = Carrier.create!(trade_name: 'DSLog', corporate_name: 'Death Star Log', domain: '@dslog.com.br', nif: 45678901234567, address: 'Canto da Galáxia, 1990', city: 'Death Star', state: 'VC')
        user = User.create!(name: "Luke Skywalker", email: "lukeskyson@dslog.com.br", password: 'unlikemyfather', carrier: carrier)
        order =  Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        #Act
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
        order = Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        #Act
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
        order =  Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        vehicle = Vehicle.create!(license_plate: 'CBU-1711', brand: 'Fuord', model: 'Fuord Truck Max', fabrication_year: '2018', max_capacity: 1000, carrier: carrier)
        second_vehicle = Vehicle.create!(license_plate: 'BLR-4116', brand: 'Wukas Vagas', model: 'Wukas T1000', fabrication_year: '2020', max_capacity: 2500, carrier: carrier)
        #Act
        login_as(user)
        visit root_path
        click_on 'Visualizar pedidos'
        click_on 'Ver detalhes'
        click_on 'Clique aqui para designar um veículo antes de aceitar o pedido'
        select 'Fuord Truck Max', from: 'Designar veículo'
        click_on 'Enviar'
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
        order =  Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        #Act
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
        order =  Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier, status: 5, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        #Act
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

    it 'e atualiza informações sobre a entrega' do
        #Arrange
        admin = Admin.create!(email: 'darth@sistemadefrete.com.br', password: 'iamyourfather')
        carrier = Carrier.create!(trade_name: 'DSLog', corporate_name: 'Death Star Log', domain: '@dslog.com.br', nif: 45678901234567, address: 'Canto da Galáxia, 1990', city: 'Death Star', state: 'VC')
        user = User.create!(name: "Luke Skywalker", email: "lukeskyson@dslog.com.br", password: 'unlikemyfather', carrier: carrier)
        order = Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier, status: 5, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        #Act
        login_as(user)
        visit root_path
        click_on 'Visualizar pedidos'
        click_on 'Ver detalhes'
        click_on 'Adicionar atualização de rota'
        fill_in 'Coordenadas geográficas', with: "22°49\'44.9\"S 43°20\'45.2\"W"
        fill_in 'Data de atualização', with: '29/05/2022'
        fill_in 'Horário de atualização', with: '17h58min'
        select order.delivery_address, from: 'Pedido'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content("Última atualização de coordenadas: 22°49\'44.9\"S 43°20\'45.2\"W" )
        expect(page).to have_content('Horário de atualização: 17h58min')
        expect(page).to have_content('Data de atualização: 29/05/2022')
    end

    it 'e o código do pedido não se altera após a edição' do
        #Arrange
        admin = Admin.create!(email: 'darth@sistemadefrete.com.br', password: 'iamyourfather')
        carrier = Carrier.create!(trade_name: 'DSLog', corporate_name: 'Death Star Log', domain: '@dslog.com.br', nif: 45678901234567, address: 'Canto da Galáxia, 1990', city: 'Death Star', state: 'VC')
        user = User.create!(name: "Luke Skywalker", email: "lukeskyson@dslog.com.br", password: 'unlikemyfather', carrier: carrier)
        order =  Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        vehicle = Vehicle.create!(license_plate: 'CBU-1711', brand: 'Fuord', model: 'Fuord Truck Max', fabrication_year: '2018', max_capacity: 1000, carrier: carrier)
        second_vehicle = Vehicle.create!(license_plate: 'BLR-4116', brand: 'Wukas Vagas', model: 'Wukas T1000', fabrication_year: '2020', max_capacity: 2500, carrier: carrier)
        code = order.code
        #Act
        login_as(user)
        visit root_path
        click_on 'Visualizar pedidos'
        click_on 'Ver detalhes'
        click_on 'Clique aqui para designar um veículo antes de aceitar o pedido'
        select 'Fuord Truck Max', from: 'Designar veículo'
        click_on 'Enviar'
        click_on 'Aceitar pedido'
        #Assert
        expect(page).to have_content('Volume: 0.015m³')
        expect(page).to have_content('Peso do produto: 15kg')
        expect(page).to have_content('Endereço de entrega: Largo das Neves, 500')
        expect(page).to have_content('Nome do destinatário: Arya Stark')
        expect(page).to have_content("Código para rastreio: #{code}")
        expect(page).to have_content('Status: Pedido aceito')
        expect(page).to have_button('Finalizar pedido')
    end
end