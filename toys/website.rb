#!/usr/bin/env ruby
#
# website.rb

require 'sinatra'

get '/' do
  "Hello world!"
end

before do
  content_type :txt
  @defeat = {rock: :scissors, paper: :rock, scissors: :paper}
  @throws = @defeat.keys
end

get '/throw/:type' do
  player_throw = params[:type].to_sym

  if !@throws.include?(player_throw)
    halt 403, "You must throw one of: #{@throws}"
  end

  computer_throw = @throws.sample

  if player_throw == computer_throw
    "You tied the computer, try again!"
  elsif computer_throw == @defeat[player_throw]
    "Nice! #{player_throw} beats #{computer_throw}"
  else
    "Ouch: #{computer_throw} beats #{player_throw}"
  end
end

