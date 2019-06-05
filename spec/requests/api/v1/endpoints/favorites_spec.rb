require 'rails_helper'

describe 'Favorites API endpoint' do
  describe 'POST /api/v1/favorites' do
    it 'Adds favorite to a user if valid API key' do
      user = User.create(
                  email: 'email',
                  password_digest: 'password',
                  api_key: 'api_key')

      valid_params = {
                  "location": "Denver, CO",
                  "api_key": "api_key"
                }

      post '/api/v1/favorites', params: valid_params

      expect(response).to be_successful
      expect(response.status).to eq(201)

      json_response = JSON.parse(response.body)

      expected_response = { 'location' => 'Denver, CO',
                            'api_key' => 'api_key' }
      expect(json_response).to eq(expected_response)

      user.reload
      expect(user.favorites.count).to eq(1)
    end

    it 'errors with an invalid api_key' do
      invalid_params = {
                  "location": "Denver, CO",
                  "api_key": "invalid_api_key"
                }

      post '/api/v1/favorites', params: invalid_params

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
    end
  end

  describe 'GET /api/v1/favorites' do
    it 'returns weather forecasts for a user favorites' do
      user = User.create(
                  email: 'email',
                  password_digest: 'password',
                  api_key: 'api_key')

      forecast = Forecast.create(
        city: 'Denver',
        state: 'CO',
        city_state: 'denver,co',
        country: 'United States',
        lat: '1',
        long: '1',
        details: 'Darksky Details'
      )

      Favorite.create(user_id: user.id, forecast_id: forecast.id, location: 'denver,co')

      valid_params = { "api_key": "api_key" }

      get '/api/v1/favorites', params: valid_params

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body)

      expect(json_response[0]['location']).to be_present
      expect(json_response[0]['current_weather']).to be_present
    end

    it 'errors if invalid api key' do
      invalid_params = {
                  "api_key": "invalid_api_key"
                }

      get '/api/v1/favorites', params: invalid_params

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
    end
  end

  describe 'DELETE /api/v1/favorites' do
    before :each do
      @user = User.create(
        email: 'email',
        password_digest: 'password',
        api_key: 'api_key')

      forecast = Forecast.create(
        city: 'Denver',
        state: 'CO',
        city_state: 'denver,co',
        country: 'United States',
        lat: '1',
        long: '1',
        details: 'Darksky Details'
        )

      Favorite.create(user_id: @user.id, forecast_id: forecast.id, location: 'Denver, CO')
    end

    it 'Deletes a favorite from a user with a valid api key' do
      expect(@user.favorites.count).to eq(1)

      valid_params = {
                  "location": "Denver, CO",
                  "api_key": "api_key"
                }

      delete '/api/v1/favorites', params: valid_params

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(@user.favorites.count).to eq(0)
    end

    it 'errors if invalid api_key' do
      invalid_api_params = {
                  "location": "Denver, CO",
                  "api_key": "invalid_api_key"
                }

      delete '/api/v1/favorites', params: invalid_api_params
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
    end

    it 'errors if invalid favorite' do
      invalid_favorite_params = {
                  "location": "Invalid favorite",
                  "api_key": "api_key"
                }

      delete '/api/v1/favorites', params: invalid_favorite_params
      expect(response).to_not be_successful
      expect(response.status).to eq(401)
    end
  end
end
