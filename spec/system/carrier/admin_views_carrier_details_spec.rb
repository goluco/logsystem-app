require 'rails_helper'

describe 'Admin visita página de detalhes da transportadora' do
    it 'e vê detalhes da transportadora' do
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Transportadoras'
        click_on 'TTLog'
        #Assert
        expect(page).to have_content('Nome fantasia: TTLog')
        expect(page).to have_content('Razão social: Telene Carvalho')
        expect(page).to have_content('Domínio do e-mail: @ttlog.com.br')
        expect(page).to have_content('CNPJ: 12345678901234')
        expect(page).to have_content('Endereço: Linha Vermelha, 2543')
        expect(page).to have_content('Cidade: Salvador')
        expect(page).to have_content('Estado: BA')
    end
end