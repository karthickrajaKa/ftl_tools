# character_builder.rb

require 'ftl_tools'

module FTLTools

  # Builds characters within standard guidelines.
  class CharacterBuilder

    DATA_PATH = File.expand_path('../../data', __dir__)

    attr_reader :character

    def initialize(char = {})
      @character        = FTLTools::Character.new
      @dice             = FTLTools::Dice.new
      @char             = char
      setup
    end
 
    # Queries provided data and fills in the gaps. 
    def setup
      @character.gender   = @char.fetch('gender', generate_gender)
      @character.culture  = @char.fetch('culture', generate_culture)
      @opts               = { 'gender' => @character.gender, 'culture' => @character.culture }
      @character.name     = @char.fetch('name', generate_name)
      @character.upp      = @char.fetch('upp', generate_upp)
    end
    
    def generate_culture
      "humaniti"
    end

    def generate_gender
      %w(M F).sample
    end

    def generate_name
      # Needs work.  :)
      "Wilbur"
    end

    # Creates a hash for upp.
    def generate_upp
      upp = %i[ str dex end int edu soc].map { |stat|
        [stat, @dice.roll_2]}.to_h
      upp
    end

  end
end
