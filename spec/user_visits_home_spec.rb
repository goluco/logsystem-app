require 'rails_helper'

describe 'Usuário visita tela inicial' do
	it 'sem estar logado' do
		#Arrange

		#Act
		visit root_path
		#Assert
		expect(page).to have_link('Entrar')
		expect(page).to have_content('Sistema de Logística de Ecommerce')
		expect(page).to have_content('Rastreamento de Entrega')
	end

	it 'logado como admin' do
		#Arrange
		admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
		#Act
		login_as(admin_gen)
		visit root_path
		#Assert
		expect(page).to have_link('Sair')
		expect(page).to have_content('Adicionar transportadora')
		expect(page).to have_content('Criar nova ordem de serviço')
		expect(page).to have_content('Transportadoras')
		expect(page).to have_content('Consulta de Preços')
	end

	it 'logado como usuário' do
		#Arrange
		user_gen = User.create!(email: 'usuario_generico@transportadoragenerica.com.br', password: 'password')
		#Act
		login_as(user_gen)
		visit root_path
		#Assert
		expect(page).to have_content('Visualizar veículos')
		expect(page).to have_content('Cadastrar novo veículo')
		expect(page).to have_content('Configurar preços')
		expect(page).to have_content('Configurar prazos')
		expect(page).to have_content('Visualizar ordens de serviço')
	end
end