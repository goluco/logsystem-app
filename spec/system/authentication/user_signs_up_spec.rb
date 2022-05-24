require 'rails_helper'

describe 'Usuário cria conta' do
    it 'com sucesso' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        carrier2 = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 12345678901235, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
        #Act
        visit root_path
        click_on 'Entrar como usuário'
        click_on 'Criar uma conta'
        fill_in  'Nome', with: 'José Carlos'
        fill_in 'E-mail', with: 'josecarlos@arlog.com.br'
        select "ARLog", from: 'Transportadora'
        fill_in 'Senha', with: 'senhadozeca'
        fill_in 'Confirmar senha', with: 'senhadozeca'
        click_on 'Criar conta'
        #Assert
        expect(page).to have_content('Login efetuado com sucesso. Se não foi autorizado, a confirmação será enviada por e-mail.')
        expect(page).to have_content('josecarlos@arlog.com.br')
        expect(page).to have_button('Sair')
        user = User.last
        expect(user.name).to eq('José Carlos')
    end

    it 'com e-mail diferente da transportadora' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        carrier2 = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 12345678901235, address: 'Avenida Brasil, 5523', city: 'Rio de Janeiro', state: 'RJ')
        #Act
        visit root_path
        click_on 'Entrar como usuário'
        click_on 'Criar uma conta'
        fill_in  'Nome', with: 'José Carlos'
        fill_in 'E-mail', with: 'josecarlos@arlog.com.br'
        select "TTLog", from: 'Transportadora'
        fill_in 'Senha', with: 'senhadozeca'
        fill_in 'Confirmar senha', with: 'senhadozeca'
        click_on 'Criar conta'
        #Assert
        expect(page).to have_content('Cadastro não autorizado para seu e-mail.')
    end
end