#!/usr/bin/env ruby

# set_planet_origin.rb
# 
# Used to update characters with their planet of origin.

require 'mongo'

begin
  Mongo::Logger.logger.level = Logger::WARN
  planet_client = Mongo::Client.new(['localhost:27017'], :database => 'places')
  people_client = Mongo::Client.new(['localhost:27017'], :database => 'people')
rescue 
  puts "Cannot connect to the database."
  exit
end


places = planet_client[:planets]
people = people_client[:dragons]

def update_dragons_planet(people, planet_list)
  # Need to make this more generic.
  people.find.each do |dragon|
    unless dragon['origin_planet']
      planet = planet_list.sample
      people.update_one(
        {"_id" => dragon['_id']},
        {"$set" =>
          {
            "origin_planet" => planet,
            "group"         => "Dragons"
          }
        })
    end
  end
end

def get_planet_list(places)
  planets = Array.new
  places.find.each do |planet|
    planets << planet['name_3e']
  end
  return planets
end

planet_list = get_planet_list(places)
update_dragons_planet(people, planet_list)
#puts planet_list.sample


