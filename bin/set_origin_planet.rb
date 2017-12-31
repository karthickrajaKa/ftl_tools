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

def update_dragons_planet
  people.find.each do |dragon|
    people.update_one(
      {"_id" => dragon['_id']},
      {"$set" =>
        {
          "origin_planet" => "Birach",
          "group"         => "Dragons"
        }
      })
  end
end

def get_planet_list(places)
  planets = Hash.new(0)
  places.find.each do |planet|
    system_name = planet['name_3e']
    puts system_name
  end
end

get_planet_list(places)



