#!/usr/bin/env ruby
$VERBOSE = true

# bin/crewgen.rb

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'ftl_tools'
require 'sinatra'

crew = FTLTools::CrewGen.new

