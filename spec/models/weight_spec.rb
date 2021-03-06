require 'rails_helper'

RSpec.describe Weight, type: :model do
  describe '#valid?' do
    it 'falso quando peso mínimo está vazio' do
        #Arrange
        weight = Weight.new(name: '', min: 0, max: 10)
        #Act
        result = weight.valid?
        #Assert
        expect(result).to eq(false)
    end

    it 'falso quando peso mínimo está vazio' do
        #Arrange
        weight = Weight.new(name: '0 a 10', min: '', max: 10)
        #Act
        result = weight.valid?
        #Assert
        expect(result).to eq(false)
    end

    it 'falso quando peso máximo está vazio' do
        #Arrange
        weight = Weight.new(name: '0 a 10', min: 0, max: '')
        #Act
        result = weight.valid?
        #Assert
        expect(result).to eq(false)
    end
end
end
