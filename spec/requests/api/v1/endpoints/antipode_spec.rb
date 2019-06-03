require 'rails_helper'

describe 'Antipode API endpoint' do
  it 'returns weather of a citys antipode' do
    query = 'hongkong'
    get "/api/v1/antipode?loc=#{query}"

    expect(response).to be_successful

    json_response = JSON.parse(response.body)

    expect(json_response).to be_present

    expected = {
              	"data": [{
              		"id": "1",
              		"type": "antipode",
              		"attributes": {
              			"location_name": "Antipode City Name",
              			"forecast": {
              				"summary": "Mostly Cloudy",
              				"current_temperature": "72"
              			},
              			"search_location": "Hong Kong"
              		}
              	}]
              }

    expect(json_response).to eq(expected)
  end
end
