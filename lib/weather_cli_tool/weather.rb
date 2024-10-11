require 'httparty'
require 'json'
require 'cgi'

module WeatherCliTool
  class Weather
    API_URL = 'https://api.openweathermap.org/data/2.5/weather'

    def self.run(args)
      city = args[0] || 'Berlin'
      api_key = 'e77c5094175b840bce30326ff960d5f1'

      encoded_city = CGI.escape(city)

      response = HTTParty.get("#{API_URL}?q=#{encoded_city}&appid=#{api_key}&units=metric")
      puts response.body

      if response.success?
        weather_data = JSON.parse(response.body)
        display_weather(weather_data)
      else
        puts "Fehler beim Abrufen der Wetterdaten."
      end
    end

    def self.display_weather(data)
      city = data['name']
      temp = data['main']['temp']
      description = data['weather'][0]['description']

      puts "Wetter in #{city}:"
      puts "Temperatur: #{temp}°C"
      puts "Beschreibung: #{description.capitalize}"
    end
  end
end