class Api::V1::SessionsController < ActionController::API
  def create
    user = User.find_by(email: user_params[:email])

    if user && user.authenticate(user_params[:password])
      render json: { api_key: user.api_key }, status: 200
    else
      render json: { error: 'Unauthorized' }, status: 401
    end
  end

  private
    def user_params
      params.permit(:email, :password)
    end
end
