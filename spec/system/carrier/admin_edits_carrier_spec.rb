require 'rails_helper'

describe 'Administrador edita transportadora' do
    it 'a partir da tela inicial' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Transportadoras disponíveis'
        click_on 'TTLog'
        click_on 'Editar'
        #Assert
        expect(page).to have_field('Nome fantasia')
        expect(page).to have_field('Razão social')
        expect(page).to have_field('Domínio do e-mail')
        expect(page).to have_field('CNPJ')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Estado')
    end

    it 'com sucesso' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Transportadoras disponíveis'
        click_on 'TTLog'
        click_on 'Editar'
        fill_in 'Nome fantasia', with: 'TTZLog'
        fill_in 'Domínio do e-mail', with: '@ttzlog.com.br'
        fill_in 'Cidade', with: 'Rio de Janeiro'
        fill_in 'Estado', with: 'RJ'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Dados atualizados com sucesso')
        expect(page).to have_content('TTZLog')
        expect(page).to have_content('@ttzlog.com.br')
        expect(page).to have_content('Rio de Janeiro')
        expect(page).to have_content('RJ')
        expect(page).not_to have_content('TTLog')
        expect(page).not_to have_content('@ttlog.com.br')
        expect(page).not_to have_content('Salvador')
        expect(page).not_to have_content('BA')
    end

    it 'com dados incorretos' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Transportadoras disponíveis'
        click_on 'TTLog'
        click_on 'Editar'
        fill_in 'Nome fantasia', with: ''
        fill_in 'Domínio do e-mail', with: 'ttzlogcombr'
        fill_in 'CNPJ', with: '12345678901234567'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Dados não atualizados')
        expect(page).to have_content('Nome fantasia não pode ficar em branco')
        expect(page).to have_content('Domínio do e-mail não é válido')
        expect(page).to have_content('CNPJ não possui o tamanho esperado (14 caracteres)')
    end
end