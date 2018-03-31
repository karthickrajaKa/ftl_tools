# planet.rb
# Trying to figure out the math of gravity, density, etc.

# Bibilography
#   http://pubs.usgs.gov/gip/interior/
#   "G" - https://en.wikipedia.org/wiki/Gravitational_constant

class Planet
  G           = 6.674e-11
  PI          = 3.14
  MIN_GRAVITY = 0.5
  MAX_GRAVITY = 1.5
  ERTH_DENSE  = 5.514e3

  attr_accessor :gravity
  attr_reader   :radius

  def initialize(density, uwp = '777777')
    @uwp      = uwp
    @radius   = radius
    @density  = density
    @volume   = volume
    @mass     = mass
  end

  def radius
    size    = @uwp[0].to_i(16)
    if size == 0
      return nil
    end
    size_in_miles = size * 1000
    size_in_miles * 0.8
  end 

  def square(num)
    num * num
  end

  def cube(num)
    num * num * num
  end

  def volume
    (4 / 3.0) * PI * cube(@radius)
  end

  def mass
    @volume * @density
  end

  def gravity
    radius_in_meters = @radius * 1000
    puts("Mass is #{@mass}.")
    G * @mass / square(radius_in_meters)
  end
end
