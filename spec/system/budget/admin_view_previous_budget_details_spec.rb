require 'rails_helper'

describe 'Admin visita página de detalhes de orçamento' do
    it 'a partir da tela inicial' do
        #Arrange
        #Arrange
        admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
        first_carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
        budget = Budget.create!(carrier: first_carrier, value: 120.0, deadline: 5)
        #Act
        login_as(admin_gen, scope: :admin)
        visit root_path
        click_on 'Gerenciar orçamentos'
        click_on 'TTLog | R$ 120.0 | 5 dias úteis'
        #Assert
        expect(current_path).to eq(budget_path(budget.id))
        expect(page).to have_content('Valor: R$120.0')
        expect(page).to have_content('Prazo: 5 dias úteis')
        expect(page).to have_content('Transportadora: TTLog')
        expect(page).to have_content("Data do orçamento: #{budget.created_at}")
    end
end