require 'rails_helper'

describe 'Sessions API Endpoint' do
  describe 'POST /api/v1/sessions' do
    it 'valid login credentials, returns the users API key' do
    User.create(
      email: 'whatever@example.com',
      password: 'password',
      api_key: 'api_key')

      valid_params = {
                        "email": "whatever@example.com",
                        "password": "password",
                        "password_confirmation": "password"
                      }

      post '/api/v1/sessions', params: valid_params

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body)
      expect(json_response['api_key']).to eq('api_key')
    end

    it 'invalid login credentials, returns unathorized' do
      invalid_params = {
                        "email": "whatever@example.com",
                        "password": "invalid_password",
                        "password_confirmation": "invalid_password"
                      }

      post '/api/v1/sessions', params: invalid_params

      expect(response.status).to eq(401)

      json_response = JSON.parse(response.body)
      expect(json_response).to eq({ 'error' => 'Unauthorized' })
    end
  end
end
