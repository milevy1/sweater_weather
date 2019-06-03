require 'rails_helper'

describe 'Forecast API Endpoint' do
  it 'returns weather data for a city' do
    query = 'denver,co'
    get "/api/v1/forecast?location=#{query}"

    expect(response).to be_successful

    json_response = JSON.parse(response.body)

    expect(json_response['data']).to be_present
    expect(json_response['data']['id']).to be_present
    expect(json_response['data']['attributes']).to be_present
    expect(json_response['data']['attributes']['city']).to be_present
    expect(json_response['data']['attributes']['state']).to be_present
    expect(json_response['data']['attributes']['country']).to be_present
    expect(json_response['data']['attributes']['details']).to be_present
  end

  it 'updates the Forecast if it has not been updated in one hour' do
    query = 'denver,co'
    old_forecast = Forecast.create(
      city: 'Denver',
      state: 'CO',
      city_state: query,
      country: 'United States',
      lat: '39.7392358',
      long: '-104.990251',
      details: 'Old DarkSky details'
    )

    two_hours_ago = Time.now - 2.hours.seconds
    old_forecast.updated_at = two_hours_ago
    old_forecast.save

    get "/api/v1/forecast?location=#{query}"
    old_forecast.reload

    expect(Forecast.count).to eq(1)
    expect(old_forecast.details).to_not eq('Old DarkSky details')
    expect(old_forecast.updated_at).to_not eq(two_hours_ago)
  end
end
