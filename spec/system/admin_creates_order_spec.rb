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
end