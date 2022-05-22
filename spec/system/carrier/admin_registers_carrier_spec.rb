require 'rails_helper'

describe 'Administrador registra nova transportadora' do
	it 'a partir da tela inicial' do
	  	#Arrange
		admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
		#Act
		login_as(admin_gen, scope: :admin)
		visit root_path
		click_on 'Adicionar transportadora'
		#Assert
		expect(page).to have_content('Formulário de cadastro de nova transportadora')
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
		#Act
		login_as(admin_gen, scope: :admin)
		visit root_path
		click_on 'Adicionar transportadora'
		fill_in 'Nome fantasia', with: 'ARLog'
		fill_in 'Razão social', with: 'Lucas Silva e Silva'
		fill_in 'Domínio do e-mail', with: '@arlog.com.br'
		fill_in 'CNPJ', with: '12345678901234'
		fill_in 'Endereço', with: 'Avenida Brasil, 5523'
		fill_in 'Cidade', with: 'Rio de Janeiro'
		fill_in 'Estado', with: 'RJ'
		click_on 'Enviar'
		#Assert
		expect(current_path).to eq(root_path)
		expect(page).to have_content('Transportadora cadastrada com sucesso')
	end

	it 'com dados incompletos' do
		#Arrange
		admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
		#Act
		login_as(admin_gen, scope: :admin)
		visit root_path
		click_on 'Adicionar transportadora'
		fill_in 'Nome fantasia', with: 'ARLog'
		fill_in 'Razão social', with: ''
		fill_in 'Domínio do e-mail', with: ''
		fill_in 'CNPJ', with: ''
		fill_in 'Endereço', with: 'Avenida Brasil, 5523'
		fill_in 'Cidade', with: ''
		fill_in 'Estado', with: 'RJ'
		click_on 'Enviar'
		#Assert
		expect(page).to have_content('Transportadora não cadastrada')
		expect(page).to have_content('Razão social não pode ficar em branco')
		expect(page).to have_content('Domínio do e-mail não pode ficar em branco')
		expect(page).to have_content('CNPJ não pode ficar em branco')
		expect(page).to have_content('Cidade não pode ficar em branco')
	end

	it 'com dados na formatação incorreta' do
		#Arrange
		admin_gen = Admin.create!(email: 'administrador_generico@sistemadefrete.com.br', password: 'password')
		#Act
		login_as(admin_gen, scope: :admin)
		visit root_path
		click_on 'Adicionar transportadora'
		fill_in 'Nome fantasia', with: 'ARLog'
		fill_in 'Razão social', with: 'Lucas Silva e Silva'
		fill_in 'Domínio do e-mail', with: 'domínioqualquer'
		fill_in 'CNPJ', with: '1234567890aerge'
		fill_in 'Endereço', with: 'Avenida Brasil, 5523'
		fill_in 'Cidade', with: 'Rio de Janeiro'
		fill_in 'Estado', with: 'RJ'
		click_on 'Enviar'
		#Assert
		expect(page).to have_content('Transportadora não cadastrada')
		expect(page).to have_content('Domínio do e-mail não é válido')
		expect(page).to have_content('CNPJ não é um número')
		expect(page).to have_content('CNPJ não possui o tamanho esperado (14 caracteres)')
	end
end