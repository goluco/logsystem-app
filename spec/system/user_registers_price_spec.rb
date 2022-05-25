require 'rails_helper'

describe 'Usuário registra preço' do
    it 'a partir da tela inicial' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        volume = Volume.create!(min: 0.001, max: 0.005)
        weight = Weight.create!(min: 0, max: 10)
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
        #Act
        #Assert
    end

    it 'com dados incompletos' do
        #Arrange
        #Act
        #Assert
    end
end