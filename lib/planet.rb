#planet.rb

class Planet

  attr_reader :name, :location, :uwp

  def initialize(data)
    @name     = data['name']
    @uwp      = data['uwp']
    @location = data['location']
  end

  def trade_codes
    # Yeah, really bogus. Will calculate more when I have the 
    # Other processes working. 
    ['Ag']
  end

  def to_s
    trade_code_string = trade_codes.join(' ')
    "#{@name}: UWP #{@uwp}, Location: #{@location}, Trade: #{trade_code_string}"
  end
end  
