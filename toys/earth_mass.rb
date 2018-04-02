#!/usr/bin/env ruby

# Just testing base math using Earth's measurements.
# Measurements are from wikipedia "Earth"
G           = 6.674e-11   # Universoal constant
K           = 1000        # To convert from kilo to whatever-o
mass_kg     = 5.97237e24  # kg
density     = 5.514       # g/cm3
radius_km   = 6371        # 
radius_m    = radius_km * K
surface_km2 = 51007200
volume_km3  = 1.08321e12
volume_m3   = volume_km3 * K * K * K * K
            # (K*K*K) to convert to m3, then one more for m to cm.
mass_calc   = volume_m3 * density

puts(mass_kg)

gravity     = G * mass_kg / ( radius_m * radius_m)
puts("%2.3f" % gravity)
puts("Volume (m3): %e" % volume_m3)
puts("Going the other way.")
# If mass = density * volume
# then
#   volume  = mass / density
#   density = mass / volume

puts("Calculated mass: %e" % mass_calc)
puts("Calculated dendity %2.3f" % ( mass_calc / volume_m3))
puts("Calculated volume (m3): %e" % (mass_calc / density))
mass_diff = (mass_kg - mass_calc).abs
puts("Difference between calculated and wikipedia mass: %e" % ((mass_calc - mass_kg).abs) )
