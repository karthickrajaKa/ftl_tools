# ship.rb

module FTLTools

  # Provides the basic Ship object
  class Ship

    attr_accessor :name, :drive_size, :hold_size, :hull_size, :passengers, :service, :weapons 
     
    def medic?
      @hull_size >= 200
    end

    def steward?
      @passengers >= 1
    end

    def engineer_count
      (@drive_size / 35.0).ceil 
    end

  end
end
