require 'rails_helper'

describe 'Users API Endpoint' do
  describe 'POST /api/v1/users' do
    it 'creates a new user with valid params' do
      valid_params = {
                        "email": "whatever@example.com",
                        "password": "password",
                        "password_confirmation": "password"
                      }

      post '/api/v1/users', params: valid_params

      expect(response).to be_successful
      expect(response.status).to eq(201)

      json_response = JSON.parse(response.body)
      expect(json_response['api_key']).to be_present
    end

    it 'errors with invalid params' do
      invalid_params = {
                        "email": "whatever@example.com"
                      }

      post '/api/v1/users', params: invalid_params

      expect(response.status).to eq(400)

      json_response = JSON.parse(response.body)
      expect(json_response).to eq({ error: 'Failed to save new user.' })
    end
  end
end
