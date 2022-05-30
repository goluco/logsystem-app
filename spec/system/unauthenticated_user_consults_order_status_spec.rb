require 'rails_helper'

describe 'Usuário não autenticado verifica atualizações do pedido' do
    it 'e recebe atualizações de seu pedido' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'DSLog', corporate_name: 'Death Star Log', domain: '@dslog.com.br', nif: 45678901234567, address: 'Canto da Galáxia, 1990', city: 'Death Star', state: 'VC')
        user = User.create!(name: "Luke Skywalker", email: "lukeskyson@dslog.com.br", password: 'unlikemyfather', carrier: carrier)
        order = Order.create!(volume: 0.015, product_weight: 15, delivery_address: 'Largo das Neves, 500', recipient_name: 'Arya Stark', carrier: carrier, status: 5, product_sku: 'abcde45678', product_address: 'Rua dos Malandros, 97, Sao Tomé - RJ', distance: 700)
        infolog = Infolog.create!(coordinates: '22°49\'44.9\"S 43°20\'45.2\"W', date: "29/05/2022", time: "23h56min", order_id: order.id)
        #Act
        visit root_path
        fill_in 'Rastreamento de Entrega: insira o código do pedido', with: order.code 
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Última atualização de coordenadas: 22°49\'44.9\"S 43°20\'45.2\"W')
        expect(page).to have_content('Data de atualização: 29/05/2022')
        expect(page).to have_content('Horário de atualização: 23h56min')
    end
end