require 'rails_helper'

describe 'Usuário configura intervalos de peso' do
    it 'a partir da tela inicial' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        click_on 'Adicionar intervalo de peso'
        #Assert
        expect(page).to have_field('Faixa por escrito')
        expect(page).to have_field('Peso mínimo')
        expect(page).to have_field('Peso máximo')
    end

    it 'com sucesso' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        click_on 'Adicionar intervalo de peso'
        fill_in 'Faixa por escrito', with: '1 a 10'
        fill_in 'Peso mínimo', with: 1
        fill_in 'Peso máximo', with: 10
        click_on 'Enviar'
        #Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Intervalo de peso cadastrado com sucesso')
    end

    it 'com dados incompletos' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        click_on 'Adicionar intervalo de peso'
        fill_in 'Faixa por escrito', with: '1 a 10'
        fill_in 'Peso mínimo', with: ''
        fill_in 'Peso máximo', with: 10
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Peso mínimo não pode ficar em branco')
    end
end