require 'rails_helper'

describe 'Usuário visualiza prazos registrados' do
    it 'visualiza todas os prazos cadastradas' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        deadline = Deadline.create!(working_days: 2, min_distance: 0, max_distance: 100, carrier: carrier)
        deadline2 = Deadline.create!(working_days: 5, min_distance: 101, max_distance: 300, carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configuração de prazos'
        #Assert
        expect(page).to have_content('Prazo: 2 dias úteis | De: 0KM | A: 100KM')
        expect(page).to have_content('Prazo: 5 dias úteis | De: 101KM | A: 300KM')
    end

    it 'e não existem prazos cadastradas' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configuração de prazos'
        #Assert
        expect(page).to have_content('Não existem prazos cadastrados.')
    end

    it 'e não vê os prazos cadastrados por outras transportadoras' do
        #Arrange
        carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
        carrier2 = Carrier.create!(trade_name: 'ARLog', corporate_name: 'Lucas Silva e Silva', domain: '@arlog.com.br', nif: 23456789012345, address: 'Rua Inexistente, 1500', city: 'Citrolândia', state: 'AZ')
        deadline = Deadline.create!(working_days: 2, min_distance: 0, max_distance: 100, carrier: carrier)
        deadline2 = Deadline.create!(working_days: 5, min_distance: 101, max_distance: 300, carrier: carrier)
        deadline3 = Deadline.create!(working_days: 3, min_distance: 0, max_distance: 150, carrier: carrier2)
        deadline4 = Deadline.create!(working_days: 7, min_distance: 151, max_distance: 500, carrier: carrier2)
        #Act
        login_as(user_gen)
        visit root_path
        click_on 'Configuração de prazos'
        #Assert
        expect(page).to have_content('Prazo: 2 dias úteis | De: 0KM | A: 100KM')
        expect(page).to have_content('Prazo: 5 dias úteis | De: 101KM | A: 300KM')
        expect(page).not_to have_content('Prazo: 3 dias úteis | De: 0KM | A: 150KM')
        expect(page).not_to have_content('Prazo: 7 dias úteis | De: 151KM | A: 500KM')
    end
end