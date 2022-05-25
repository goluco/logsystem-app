require 'rails_helper'

describe 'Usuário configura deadlines' do
    it 'a partir da tela inicial' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configuração de prazos'
        click_on 'Adicionar nova configuração de prazo'
        #Assert
        expect(page).to have_field('Prazo (em dias úteis')
        expect(page).to have_field('De')
        expect(page).to have_field('A')
    end

    it 'com sucesso' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configuração de prazos'
        click_on 'Adicionar nova configuração de prazo'
        fill_in 'Prazo (em dias úteis)', with: 2
        fill_in 'De', with: 0
        fill_in 'A', with: 100
        click_on 'Enviar'
        #Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Nova configuração de prazo adicionada com sucesso')
    end

    it 'com dados incompletos' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configuração de prazos'
        click_on 'Adicionar nova configuração de prazo'
        fill_in 'Prazo (em dias úteis)', with: ''
        fill_in 'De', with: ''
        fill_in 'A', with: 100
        click_on 'Enviar'
        #Assert
        expect(page).not_to have_content('Nova configuração de prazo adicionada com sucesso')
        expect(page).to have_content('Não foi possível adicionar nova configuração de prazo')
        expect(page).to have_content('Prazo (em dias úteis) não pode ficar em branco')
        expect(page).to have_content('De não pode ficar em branco')
    end
end