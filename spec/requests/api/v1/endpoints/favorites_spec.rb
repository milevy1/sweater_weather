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
end
