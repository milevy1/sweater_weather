class Api::V1::AntipodeController < ApplicationController
  def show
    location = params['loc']

    search_google_service = GoogleMapsService.new(location)
    search_location = search_google_service.formatted_address
    search_lat = search_google_service.latitude
    search_long = search_google_service.longitude

    amy_conn = Faraday.new('http://amypode.herokuapp.com/api/v1/antipodes') do |f|
      f.adapter Faraday.default_adapter
      f.headers['api_key'] = ENV['antipode_api_key']
    end

    amy_response = amy_conn.get do |req|
      req.params['lat'] = search_lat
      req.params['long'] = search_long
    end

    antipode_coordinates = JSON.parse(amy_response.body)['data']['attributes']
    antipode_lat = antipode_coordinates['lat'].to_s
    antipode_long = antipode_coordinates['long'].to_s

    antipode_google_service = GoogleMapsService.new("#{antipode_lat},#{antipode_long}")
    antipode_location = antipode_google_service.formatted_address

    dark_sky_service = DarkSkyService.new(antipode_lat, antipode_long)
    antipode_forecast = dark_sky_service.details

    antipode_forecast_summary = antipode_forecast['currently']['summary']
    antipode_forecast_temperature = antipode_forecast['currently']['temperature'].to_s

    expected = {
              	"data": [{
              		"id": "1",
              		"type": "antipode",
              		"attributes": {
              			"location_name": antipode_location,
              			"forecast": {
              				"summary": antipode_forecast_summary,
              				"current_temperature": antipode_forecast_temperature
              			},
              			"search_location": search_location
              		}
              	}]
              }

    render json: expected
  end
end
