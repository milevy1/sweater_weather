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
end
