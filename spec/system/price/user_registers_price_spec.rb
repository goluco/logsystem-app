require 'rails_helper'

describe 'Usuário registra preço' do
    it 'a partir da tela inicial' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        volume = Volume.create!(name: '0.001 a 0.005', min: 0.001, max: 0.005)
        weight = Weight.create!(name: '0 a 10', min: 0, max: 10)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        click_on 'Adicionar taxa'
        #Assert
        expect(page).to have_field('Taxa por KM')
        expect(page).to have_field('Volume')
        expect(page).to have_field('Peso')
    end

    it 'com sucesso' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        volume = Volume.create!(name: '0.001 a 0.005', min: 0.001, max: 0.005)
        weight = Weight.create!(name: '0 a 10', min: 0, max: 10)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        click_on 'Adicionar taxa'
        fill_in 'Taxa por KM', with: '0.5'
        select volume.name, from: 'Volume'
        select weight.name, from: 'Peso'
        select 'TTLog', from: 'Transportadora'
        click_on 'Enviar'
        #Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Taxa por KM cadastrada com sucesso')
    end

    it 'com dados incompletos' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        volume = Volume.create!(name: '0.001 a 0.005', min: 0.001, max: 0.005)
        weight = Weight.create!(name: '0 a 10', min: 0, max: 10)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        click_on 'Adicionar taxa'
        fill_in 'Taxa por KM', with: ''
        select volume.name, from: 'Volume'
        select weight.name, from: 'Peso'
        select 'TTLog', from: 'Transportadora'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Taxa por KM não pode ficar em branco')
    end

    it 'adicionando valor mínimo de cobrança' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        volume = Volume.create!(name: '0.001 a 0.005', min: 0.001, max: 0.005)
        weight = Weight.create!(name: '0 a 10', min: 0, max: 10)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configurar preços'
        click_on 'Adicionar taxa'
        fill_in 'Taxa por KM', with: '0.5'
        fill_in 'Valor mínimo de cobrança', with: 100.0
        select volume.name, from: 'Volume'
        select weight.name, from: 'Peso'
        select 'TTLog', from: 'Transportadora'
        click_on 'Enviar'
        #Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Taxa por KM cadastrada com sucesso')
    end
end