require 'rails_helper'

describe 'Admin visualiza detalhes da transportadora' do
    it 'e vê transportadoras listadas' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 12345678901235, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Transportadoras disponíveis'
        #Assert
        expect(page).to have_content('TTLog')
        expect(page).to have_content('ARLog')
    end

    it 'e não há transportadoras cadastradas' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Transportadoras disponíveis'
        #Assert
        expect(page).to have_content('Não existem transportadoras cadastradas.')
    end
end