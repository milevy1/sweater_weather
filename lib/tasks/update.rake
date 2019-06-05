namespace :update do
  desc "Updates Forecasts for top 50 US cities"
  task forecasts: :environment do
    cities.each do |city_state|
      forecast = Forecast.find_by(city_state: city_state.downcase)

      forecast ? forecast.update_details : Forecast.create_new_forecast(city_state)
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
end
