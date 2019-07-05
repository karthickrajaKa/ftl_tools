# dice_spec.rb

require 'ftl_tools'

module FTLTools

  RSpec.describe 'A set of dice' do
    let(:dice) { FTLTools::Dice.new }

    it 'rolls one die' do
      roll = dice.roll_1
      expect(roll).to be <= 6
      expect(roll).to be >= 1
    end

    it 'rolls two dice' do
      roll = dice.roll_2
      expect(roll).to be <= 12 
      expect(roll).to be >= 2
    end

    it 'rolls d66' do
      roll = dice.roll_66
      expect(roll).to be <= 66 
      expect(roll).to be >= 11
      expect((1..6)).to include(roll.digits.first)
      expect((1..6)).to include(roll.digits.last)
    end

  end

end
