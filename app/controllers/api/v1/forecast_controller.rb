class Api::V1::ForecastController < ApplicationController
  def show
    forecast = Forecast.find_by(city_state: params['location'].downcase)

    unless forecast
      latitude = google_maps_service.latitude
      longitude = google_maps_service.longitude

      forecast = Forecast.create(
        city: google_maps_service.city,
        state: google_maps_service.state,
        city_state: google_maps_service.city_state,
        country: google_maps_service.country,
        lat: latitude,
        long: longitude,
        details: darksky_service(latitude, longitude).details
      )
    end

    render json: ForecastSerializer.new(forecast)
  end

  private
    def google_maps_service
      @_google_maps_service ||= GoogleMapsService.new(params['location'])
    end

    def darksky_service(latitude, longitude)
      @_dark_sky_service ||= DarkSkyService.new(latitude, longitude)
    end
end
