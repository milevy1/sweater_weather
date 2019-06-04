class Forecast < ApplicationRecord
  has_many :favorites

  def self.find_or_create_by_location(location)
    forecast = Forecast.find_by(city_state: location)

    forecast ? forecast : create_new_forecast(location)
  end

  def self.create_new_forecast(location)
    @_google_maps_service ||= GoogleMapsService.new(location)
    latitude = @_google_maps_service.latitude
    longitude = @_google_maps_service.longitude
    @_dark_sky_service ||= DarkSkyService.new(latitude, longitude)

    Forecast.create(
      city: @_google_maps_service.city,
      state: @_google_maps_service.state,
      city_state: @_google_maps_service.city_state,
      country: @_google_maps_service.country,
      lat: latitude,
      long: longitude,
      details: @_dark_sky_service.details
    )
  end

  def update_details
    dark_sky_service ||= DarkSkyService.new(lat, long)
    self.details = dark_sky_service.details
    self.save
  end
end
