# tc_cargo.rb

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'test/unit'

require 'cargo'

class TestCargo < Test::Unit::TestCase

  def setup
    cargo_hash  = {
      'name'  => 'textiles',
      'base_price' => 1000,
      'dt_per_unit' => 4,
      'sell_mods'   => {'Ag' => 4, 'In' => -3},
      'buy_mods'    => {'In' => 5, 'Ag' => -3}
    }
    @cargo = Cargo.new(cargo_hash)
  end

  def test_name
    assert(@cargo.name        == 'textiles')
    assert(@cargo.name.class  == String)
  end

  def test_base_price
    assert(@cargo.base_price        == 1000)
    assert(@cargo.dt_per_unit.class == Integer)
  end

  def test_dt_per_unit
    assert(@cargo.dt_per_unit       == 4)
    assert(@cargo.dt_per_unit.class == Integer)
  end

  def test_sell_mods
    assert(@cargo.sell_mods.class       == Hash)
    assert(@cargo.sell_mods.count       == 2)
    assert(@cargo.sell_mods['Ag'].class == Integer)
    assert(@cargo.sell_mods['Ag']       == 4)
  end

  def test_buy_mods
    assert(@cargo.buy_mods.class       == Hash)
    assert(@cargo.buy_mods.count       == 2)
    assert(@cargo.buy_mods['Ag'].class == Integer)
    assert(@cargo.buy_mods['Ag']       == -3)
  end

end
