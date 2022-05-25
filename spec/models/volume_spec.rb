require 'rails_helper'

RSpec.describe Volume, type: :model do
    describe '#valid?' do
        it 'falso quando nome está vazio' do
            #Arrange
            volume = Volume.new(name: '', min: '', max: 0.005)
            #Act
            result = volume.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando volume mínimo está vazio' do
            #Arrange
            volume = Volume.new(name: '0.001 a 0.005', min: '', max: 0.005)
            #Act
            result = volume.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando volume máximo está vazio' do
            #Arrange
            volume = Volume.new(name: '0.001 a 0.005', min: 0.001, max: '')
            #Act
            result = volume.valid?
            #Assert
            expect(result).to eq(false)
        end
    end
end
