require 'rails_helper'

describe 'Usuário visita tela inicial' do
	it 'sem estar logado' do
		#Arrange

		#Act
		visit root_path
		#Assert
		expect(page).to have_content('Sistema de Logística de Ecommerce')
		expect(page).to have_content('Rastreamento de Entrega')
		expect(page).to have_link('Entrar')
	end

	it 'logado como admin' do
		#Arrange
		admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
		#Act
		login_as(admin_gen, scope: :admin)
		visit root_path
		#Assert
		expect(page).to have_button('Sair')
		expect(page).to have_content('Ambiente de consulta e cadastro de transportadoras e ordens de serviço')
		expect(page).to have_content('administrador_generico@sistemadefrete.com.br')
		
	end

	it 'logado como usuário' do
		#Arrange
		carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
		#Act
		login_as(user_gen)
		visit root_path
		#Assert
		expect(page).to have_button('Sair')
		expect(page).to have_content('Ambiente de consulta e cadastro de preços, prazos e veículos, bem como recebimento e aceite de ordens de serviço')
		expect(page).to have_content('usuario_generico@ttlog.com.br')
	end
end