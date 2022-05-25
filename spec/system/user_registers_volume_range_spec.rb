require 'rails_helper'

describe 'Usuário configura intervalos de volume' do
    it 'a partir da tela inicial' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        click_on 'Adicionar intervalo de volume'
        #Assert
        expect(page).to have_field('Volume mínimo')
        expect(page).to have_field('Volume máximo')
    end

    it 'com sucesso' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        click_on 'Adicionar intervalo de volume'
        fill_in 'Volume mínimo', with: 0.001
        fill_in 'Volume máximo', with: 0.005
        click_on 'Enviar'
        #Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Intervalo de volume cadastrado com sucesso')
    end

    it 'com dados incompletos' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        click_on 'Adicionar intervalo de volume'
        fill_in 'Volume mínimo', with: ''
        fill_in 'Volume máximo', with: 0.005
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Volume mínimo não pode ficar em branco')
    end
end