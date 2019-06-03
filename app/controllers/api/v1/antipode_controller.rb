class Api::V1::AntipodeController < ApplicationController
  def show
    dark_sky_service = DarkSkyService.new(
      amypode_service.antipode_lat, amypode_service.antipode_long)
    antipode_forecast = dark_sky_service.details

    antipode_forecast_summary = antipode_forecast['currently']['summary']
    antipode_forecast_temperature = antipode_forecast['currently']['temperature'].to_s

    expected = {
              	"data": [{
              		"id": "1",
              		"type": "antipode",
              		"attributes": {
              			"location_name": antipode_google_service.formatted_address,
              			"forecast": {
              				"summary": antipode_forecast_summary,
              				"current_temperature": antipode_forecast_temperature
              			},
              			"search_location": search_google_service.formatted_address
              		}
              	}]
              }

    render json: expected
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
end
