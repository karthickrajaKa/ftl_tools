# cargo.rb

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

class Cargo

  attr_reader :name, :base_price, :dt_per_unit, 
              :sell_mods, :buy_mods

  def initialize(data)
    @name = data['name']
    @base_price = data['base_price'].to_i
    @dt_per_unit  = data['dt_per_unit'].to_i
    @sell_mods    = data['sell_mods']
    @buy_mods     = data['buy_mods']
  end
end
