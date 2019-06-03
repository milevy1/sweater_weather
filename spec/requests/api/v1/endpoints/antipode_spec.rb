require 'rails_helper'

describe 'Antipode API endpoint' do
  it 'returns weather of a citys antipode' do
    query = 'hongkong'
    get "/api/v1/antipode?loc=#{query}"

    expect(response).to be_successful

    json_response = JSON.parse(response.body)

    expect(json_response['data']).to be_present
    expect(json_response['data'][0]['id']).to be_present
    expect(json_response['data'][0]['type']).to be_present
    expect(json_response['data'][0]['attributes']).to be_present
    expect(json_response['data'][0]['attributes']['location_name']).to be_present
    expect(json_response['data'][0]['attributes']['forecast']).to be_present
    expect(json_response['data'][0]['attributes']['forecast']['summary']).to be_present
    expect(json_response['data'][0]['attributes']['forecast']['current_temperature']).to be_present
    expect(json_response['data'][0]['attributes']['search_location']).to be_present
  end
end
