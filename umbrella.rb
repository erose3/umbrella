require "http"
require "json"
require "dotenv/load"

gmaps_key = ENV.fetch("GMAPS_KEY")
weather_key = ENV.fetch("WEATHER_KEY")

# Write your solution below!

pp "Hi! Where are you?"

user_location = gets.chomp

# user_location = "New York"

# pp user_location

gmap_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + gmaps_key

# https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=REPLACE_THIS_QUERY_STRING_PARAMETER_WITH_YOUR_API_TOKEN

# pp gmap_url

raw_response = HTTP.get(gmap_url)

# puts raw_response.to_s

parsed_response = JSON.parse(raw_response)

results_hash = parsed_response.fetch ("results")

first_result = results_hash.at(0)

geometry = first_result.fetch("geometry")

location = geometry.fetch("location")

lat_float = location.fetch("lat").to_s
long_float = location.fetch ("lng").to_s

lat = lat_float.to_s
long = long_float.to_s

# pp lat
# pp long

weather_url = "https://api.pirateweather.net/forecast/" + weather_key + "/" + lat + "," + long

# pp weather_url

# Place a GET request to the URL
weather_response = HTTP.get(weather_url)

parsed_weather = JSON.parse(weather_response)
hourly = parsed_weather.fetch("hourly")
data = hourly.fetch("data")

hour0 = data.at(0)

hour0_summary = hour0.fetch("summary")
hour0_rain = hour0.fetch("precipProbability")

temp = hour0.fetch("temperature")

# pp temp
# pp hour0_summary

# pp hour0_rain

if hour0_rain > 0
    pp "The forecast right now is #{hour0_summary.downcase}. You should bring an umbrella!"
else
    pp "The forecast right now is #{hour0_summary.downcase}. You should be good to go!"
end

if temp < 60
  pp "The temp is #{temp} so you might want to bring a jacket too."
end
