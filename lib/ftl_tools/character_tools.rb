# FTLTools::CharacterTools

module FTLTools
  require 'ftl_tools'

  # CharacterTools implements modules for modifying Character objects.
  # These methods are outside career data sets.
  module CharacterTools


    # In theory this is where we keep the data.
    DATA_PATH = File.expand_path('../../data', __dir__)

    def generate_traits
      traits = []
      traits << get_random_line_from_file('positive_traits.txt')
      traits << get_random_line_from_file('negative_traits.txt')
    end

    def generate_appearence
      app = ''
      app << generate_hair + ' hair, '
      app << generate_skin + ' skin'
    end

    def generate_hair
			# havenwood mentioned dropping the begin,
			# is the 'end' kept? 
			# Currently tests are broken.
      begin
				t = get_random_line_from_file('hair_tone.txt')
				b = get_random_line_from_file('hair_body.txt')
				c = get_random_line_from_file('hair_colors.txt')
				l = get_random_line_from_file('hair_length.txt')
			  new_hair = "#{b} #{t} #{c} #{l}"
      rescue SystemCallError
        new_hair = 'Straight medium brown short'
      end
    end

    def generate_skin
      begin
				skin_tone = get_random_line_from_file('skin_tones.txt')
      rescue SystemCallError
        skin_tone = 'medium'
      end
    end

    def generate_name(options)
      Name.new(options).to_s
    end

    # Takes a hash of Character object, skill, and optional level to increase.
    # Returns the modified Character object.
    # If the "skill" to be modified is a Stat, calls modify_stat.
    def increase_skill(options)
			# This should eventually change to not need the character object. 
			# Maybe.
      character = options['character']
      skill     = options['skill']
      level     = options.key?('level') ? options['level'] : 1
      if skill.split.length > 1
        stat_options 				= Hash.new
				stat_options[:upp]	= character.upp
				stat_options[:mod]	= skill
        modify_stat(stat_options)
      else
        if character.skills.key?(skill)
          character.skills[skill] += level
        else
          character.skills[skill] = level
        end
      end
    end
		module_function :increase_skill

    # Takes a hash of the UPP and the modifier, for example "+2 Int".
    # Returns a hash of the modified UPP, within the game's 2-15 limits.
    def modify_stat(options)
			# havenwood, trying to remember why I used the ArgumentError.
			# This one uses + and - input.
			# Changing this completely, it needs the stat mod and UPP hash,
			# returns UPP hash.
			upp		= options[:upp]
			mod		= options[:mod]
			level	= mod.split[0].to_i
			stat	= mod.split[1].downcase.to_sym
			upp[stat] = upp[stat] + level
			upp[stat] = [upp[stat], 15].min
			upp[stat] = [upp[stat], 2].max
			upp
    end
		module_function :modify_stat

    def generate_plot
      [get_random_line_from_file('plots.txt'), rand(1..6)]
    rescue SystemCallError
      ['Some drab plot', rand(1..6)]
    end

    def generate_temperament
			# havenwood, fixed the return.
      begin
        temperament = get_random_line_from_file('temperaments.txt')
      rescue SystemCallError
        temperament = 'Boring'
      end
    end

    # def self.morale(options = "")
    def morale(options = '')
      morale = roll_1
      if (options.class == Hash) && !options['character'].careers.empty?
        high_morales    = %w[Marine Army Firster]
        medium_morales  = %w[Navy Scout]
        options['character'].careers.each do |career, terms|
          morale += (1 * terms)      if high_morales.include?(career)
          morale += (0.5 * terms)    if medium_morales.include?(career)
        end
      end
      morale
    end

    def skill_mod(skills, skill, assume_zero = false)
      skill_value = if skills.key?(skill)
                      skills[skill]
                    elsif assume_zero
                      0
                    else
                      -3
                    end
      skill_value
    end

  end
end
