require 'rails_helper'

RSpec.describe Deadline, type: :model do
  describe '#valid?' do
    it 'falso quando prazo em dias úteis está vazio' do
      #Arrange
      deadline = Deadline.new(working_days: '', min_distance: 0, max_distance: 100)
      #Act
      result = deadline.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso quando distância mínima está vazia' do
      #Arrange
      deadline = Deadline.new(working_days: 2, min_distance: '', max_distance: 100)
      #Act
      result = deadline.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso quando distância máxima está vazia' do
      #Arrange
      deadline = Deadline.new(working_days: 2, min_distance: 0, max_distance: '')
      #Act
      result = deadline.valid?
      #Assert
      expect(result).to eq(false)
    end
  end
end
