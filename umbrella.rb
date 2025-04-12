require "http"
require "json"
require "dotenv/load"

# Write your solution below!

gmaps_key = ENV.fetch("GMAPS_KEY")
weather_key = ENV.fetch("WEATHER_KEY")

pp gmaps_key
pp weather_key
