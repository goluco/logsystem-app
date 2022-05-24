require 'rails_helper'

describe 'Usuário cadastra veículo' do
  it 'a partir da página inicial' do
    #Arrange
    carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
    #Act
    login_as(user_gen)
    visit root_path
    click_on 'Cadastrar veículo'
    #Assert
    expect(page).to have_content('Formulário de cadastro de veículos')
    expect(page).to have_field('Placa de identificação')
    expect(page).to have_field('Marca')
    expect(page).to have_field('Modelo')
    expect(page).to have_field('Ano de fabricação')
    expect(page).to have_field('Capacidade máxima de carga')
  end

  it 'com sucesso' do
    #Arrange
    carrier = Carrier.create!(trade_name: 'TTLog', corporate_name: 'Telene Carvalho', domain: '@ttlog.com.br', nif: 12345678901234, address: 'Linha Vermelha, 2543', city: 'Salvador', state: 'BA')
		user_gen = User.create!(name: 'Usuário genérico', email: 'usuario_generico@ttlog.com.br', password: 'password', carrier: carrier)
    #Act
    login_as(user_gen)
    visit root_path
    click_on 'Cadastrar veículo'
    fill_in 'Placa de identificação', with: 'CBU1711'
    fill_in 'Marca', with: 'Ford'
    fill_in 'Modelo', with: 'Ford Truck Road'
    fill_in 'Ano de fabricação', with: '2018'
    fill_in 'Capacidade máxima de carga', with: '14'
    select user_gen.carrier.trade_name, from: 'Transportadora'
    click_on 'Enviar'
    #Assert
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Veículo cadastrado com sucesso')
  end

  it 'com dados incompletos' do
  end
end