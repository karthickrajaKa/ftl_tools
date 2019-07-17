# ship.rb

module FTLTools

  # Provides the basic Ship object
  class Ship

    attr_accessor :name, :drive_size, :hold_size, :hull_size, :passengers, :service, :weapons 
     
    def medic?
      @hull_size.to_i >= 200
    end

    def steward?
      @passengers.to_i >= 1
    end

    def engineer_count
      (@drive_size.to_i / 35.0).ceil 
    end

    def gunner_count
      @weapons
    end
  end
end
