# FTLTools::Dice

# Provides basic random number generation.
module FTLTools
	class Dice
		def roll_1
			rand(1..6)
		end

		def roll_2
			roll_1 + roll_1
		end

		def roll_66
			roll = roll_1.to_s + roll_1.to_s
			roll.to_i
		end
	end
end
