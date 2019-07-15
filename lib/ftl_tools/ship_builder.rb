# ship_builder.rb

module FTLTools

  class ShipBuilder
  
    attr_reader :ship

    def initialize
      @ship   = FTLTools::Ship.new
      @dice   = FTLTools::Dice.new
    end

    def reset
      @ship   = FTLTools::Ship.new
    end

    def setup(data = {})
      @data             = data
      @ship.name        = @data.fetch('name', generate_name) 
      @ship.hull_size   = @data.fetch('hull_size', generate_hull_size)
      @ship.drive_size  = @data.fetch('drive_size', generate_drive_size)
      @ship.weapons     = @data.fetch('weapons', generate_weapons)
      @ship.passengers  = @data.fetch('passengers', generate_passengers)
      @ship.hold_size   = @data.fetch('hold_size', generate_hold_size)
      @ship.service     = @data.fetch('service', generate_service)
      return @ship
    end

    def generate_hull_size
      @dice.roll_1 * 100
    end

    def generate_drive_size
      ((@ship.hull_size.to_i / 10) * 1.5).to_i
    end

    def generate_weapons
      @ship.hull_size.to_i / 100
    end

    def generate_name
      %w('BMM-12345' 'Avenger' 'Fred and Company')
    end
     
    def generate_passengers
      @dice.roll_2
    end 

    def generate_hold_size
      hold = @dice.roll_1 * 15
      hold_max = @ship.hull_size.to_i / 10
      [hold, hold_max].min
    end

    def generate_service
      %w('Free Trader' 'Navy' 'Merchant Marine').sample
    end

  end
end
