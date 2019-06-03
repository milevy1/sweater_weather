namespace :update do
  desc "Updates Forecasts for top 50 US cities"
  task forecasts: :environment do
    cities.each do |city_state|
      forecast = Forecast.find_by(city_state: city_state.downcase)
      if forecast
        latitude = forecast.lat
        longitude = forecast.long
        forecast.details = darksky_service(latitude, longitude).details
        forecast.save
      else
        latitude = google_maps_service(city_state).latitude
        longitude = google_maps_service(city_state).longitude

        forecast = Forecast.new(
          city: google_maps_service(city_state).city,
          state: google_maps_service(city_state).state,
          city_state: google_maps_service(city_state).city_state,
          country: google_maps_service(city_state).country,
          lat: latitude,
          long: longitude,
          details: darksky_service(latitude, longitude).details
        )

        if forecast.save
          puts "Successfully created Forecast for #{city_state}."
        else
          puts "Error creating Forecast for #{city_state}."
        end
      end
      
      # Reset service connection for next city_state
      @_google_maps_service = nil
      @_dark_sky_service = nil
    end
  end

  def cities
    [
    'New York,NY',
    'Los Angeles,CA',
    'Chicago,IL',
    'Houston,TX',
    'Philadelphia,PA',
    'Phoenix,AZ',
    'San Antonio,TX',
    'San Diego,CA',
    'Dallas,TX',
    'San Jose,CA',
    'Austin,TX',
    'Jacksonville,FL',
    'San Francisco,CA',
    'Indianapolis,IN',
    'Columbus,OH',
    'Fort Worth,TX',
    'Charlotte,NC',
    'Seattle,WA',
    'Denver,CO',
    'El Paso,TX',
    'Detroit,MI',
    'Washington,DC',
    'Boston,MA',
    'Memphis,TN',
    'Nashville,TN',
    'Portland,OR',
    'Oklahoma City,OK',
    'Las Vegas,NV',
    'Baltimore,MD',
    'Louisville,KY',
    'Milwaukee,WI',
    'Albuquerque,NM',
    'Tucson,AZ',
    'Fresno,CA',
    'Sacramento,CA',
    'Kansas City,MO',
    'Long Beach,CA',
    'Mesa,AZ',
    'Atlanta,GA',
    'Colorado Springs,CO',
    'Virginia Beach,VA',
    'Raleigh,NC',
    'Omaha,NE',
    'Miami,FL',
    'Oakland,CA',
    'Minneapolis,MN',
    'Tulsa,OK',
    'Wichita,KS',
    'New Orleans,LA',
    'Arlington,TX'
    ]
  end

  private
    def google_maps_service(address)
      @_google_maps_service ||= GoogleMapsService.new(address)
    end

    def darksky_service(latitude, longitude)
      @_dark_sky_service ||= DarkSkyService.new(latitude, longitude)
    end
end
