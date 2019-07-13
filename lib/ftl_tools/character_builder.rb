# character_builder.rb

#require 'ftl_tools'

module FTLTools

  # Builds characters within standard guidelines.
  class CharacterBuilder

    DATA_PATH = File.expand_path('../../data', __dir__)

    attr_reader :character

    def initialize()
      @character        = FTLTools::Character.new
      @dice             = FTLTools::Dice.new
    end

    # Resets the builder to clear out old objects.
    def reset
      @character        = FTLTools::Character.new
    end

    # Queries provided data and fills in the gaps. 
    def setup(char = {})
      @char             = char
      @character.gender   = @char.fetch('gender', generate_gender)
      @character.culture  = @char.fetch('culture', generate_culture)
      @opts               = { 'gender' => @character.gender, 'culture' => @character.culture }
      @character.name     = @char.fetch('name', generate_name)
      @character.upp      = @char.fetch('upp', generate_upp)
      return @character
    end
    
    def generate_culture
      "humaniti"
    end

    def generate_gender
      %w(M F).sample
    end

    def generate_name
      %w( A B C D E F G H I J K L M N O P Q R S T U V W X Y Z).sample
    end

    # Creates a hash for upp.
    def generate_upp
      upp = %i[ str dex end int edu soc].map { |stat|
        [stat, @dice.roll_2]}.to_h
      upp
    end

  end
end
