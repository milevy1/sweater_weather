class AntipodeSerializer
  attr_reader :search_location, :antipode_location,
    :antipode_forecast_summary, :antipode_forecast_temperature

  def initialize(data)
    @search_location = data[:search_location]
    @antipode_location = data[:antipode_location]
    @antipode_forecast_summary = data[:antipode_forecast_summary]
    @antipode_forecast_temperature = data[:antipode_forecast_temperature]
  end

  def json
    {
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
  end
end
