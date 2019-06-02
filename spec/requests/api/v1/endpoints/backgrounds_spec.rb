require 'rails_helper'

describe 'Backgrounds API endpoint' do
  it 'returns an image url or the city_state parameter' do
    query = 'denver,co'
    get "/api/v1/backgrounds?location=#{query}"

    expect(response).to be_successful

    json_response = JSON.parse(response.body)

    expect(json_response).to be_present
  end
end
