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
end
