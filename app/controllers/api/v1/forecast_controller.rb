class Api::V1::ForecastController < ApplicationController
  def show
    location = forecast_params[:location].gsub(/\s+/, '').downcase
    forecast = Forecast.find_or_create_by_location(location)

    if forecast.updated_at < (Time.now - 2.hours.seconds)
      forecast.update_details
    end

    render json: ForecastSerializer.new(forecast)
  end

  private
    def forecast_params
      params.permit(:location)
    end

    def google_maps_service
      @_google_maps_service ||= GoogleMapsService.new(params['location'])
    end

    def darksky_service(latitude, longitude)
      @_dark_sky_service ||= DarkSkyService.new(latitude, longitude)
    end
end
