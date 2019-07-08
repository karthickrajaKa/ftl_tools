#!/usr/bin/env ruby
$VERBOSE = true

# bin/crewgen.rb

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'sinatra'
require 'ftl_tools'

module FTLTools

  FTLTools::CrewGen.configure do
    working_dir     = File.dirname(__FILE__).split('/')
    working_dir[-1] = 'views'
    views_dir       = working_dir.join('/')
    FTLTools::CrewGen.set :views, views_dir 
  end

  FTLTools::CrewGen.get('/crew') do
    erb :crew
  end

end
