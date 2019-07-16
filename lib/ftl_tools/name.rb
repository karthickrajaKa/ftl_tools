# names.rb
#

require 'sqlite3'

module FTLTools

  # Provides First and Last name based on gender and optionally species.
  class Name

    # The goal is to have everything stored properly.
    PROJECT_PATH = __dir__

    # Where the database should be.
    DATA_PATH = File.join(PROJECT_PATH, '../../data')

    attr_reader :name

    def initialize(options)
      @gender   ||= options['gender']
      @species  = get_species(options)
      @name     = new_name
    end

    def get_species(options)
      available_species = ['humaniti']
      if options.key?('species') && available_species.include?(options['species'])
        species = options['species']
      else
        species = available_species.sample
      end
      species
    end

    # Pulls a first name from the database, based on gender.
    # Gender required but defaults to male.
    # Requires sqlite3 functionality and the database file.
    def first_name
      gender = if @gender == 'F'
                 'female'
               else
                 'male'
               end
      begin
        db = SQLite3::Database.open "#{DATA_PATH}/names.db"
        first_name_query = db.prepare "SELECT * from humaniti_#{gender}_first ORDER BY RANDOM() LIMIT 1"
        first_name_result = first_name_query.execute
        first_name = first_name_result.first
      rescue NameError
        namefile = "data/#{@species}_#{gender}_firstnames"
        name = name_from_file(namefile)
        return name
      ensure
        first_name_query.close if first_name_query
        db.close if db
      end
      first_name[0].to_s
    end

    def name_from_file(file)
      if File.exist?(file)
        name_file   = File.open(file, 'r')
        name_array  = []
        name_file.each do |line|
          name_array << line.chomp
        end
        name = name_array.sample
      else
        name = 'Fred'
      end
      name
    end

    # Pulls a last name from the database. In the future based on culture.
    # Requires sqlite3 functionality and the database file.
    def last_name
      db = SQLite3::Database.open "#{DATA_PATH}/names.db"
      last_name_query = db.prepare 'SELECT * from humaniti_last ORDER BY RANDOM() LIMIT 1'
      last_name_result = last_name_query.execute
      last_name = last_name_result.first
      last_name[0].to_s
    rescue StandardError
      namefile = "data/#{@species}_lastnames"
      name_from_file(namefile)
    ensure
      last_name_query.close if last_name_query
      db.close if db
    end

    # Needs gender, produces first and last name as a single string.
    def new_name
      f_name    = first_name
      l_name    = last_name
      "#{f_name} #{l_name}"
    end

    def to_s
      @name
    end
  end
end
