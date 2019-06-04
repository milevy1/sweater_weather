class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  
  def create
    user = User.new(user_params)
    if user.save
      api_key = user.create_api_key
      render json: { api_key: api_key }, status: 201
    else
      render json: { error: 'Failed to save new user.' }, status: 400
    end
  end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end
