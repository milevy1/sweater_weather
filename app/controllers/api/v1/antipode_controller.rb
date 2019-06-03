class Api::V1::AntipodeController < ApplicationController
  def show
    antipode = AntipodeSerializer.new(
      {
        search_location: search_google_service.formatted_address,
        antipode_location: antipode_google_service.formatted_address,
        antipode_forecast_summary: dark_sky_service.forecast_summary,
        antipode_forecast_temperature: dark_sky_service.forecast_temperature
      }
    )

    render json: antipode.json
  end

  private
    def search_google_service
      @_search_google_service ||= GoogleMapsService.new(params['loc'])
    end

    def amypode_service
      @_amypode_service ||= AmypodeService.new(
        search_google_service.latitude, search_google_service.longitude)
    end

    def antipode_google_service
      @_antipode_google_service ||= GoogleMapsService.new(
        "#{amypode_service.antipode_lat},#{amypode_service.antipode_long}")
    end

    def dark_sky_service
      @_dark_sky_service ||= DarkSkyService.new(
        amypode_service.antipode_lat, amypode_service.antipode_long)
    end
end
