class Api::V1::FavoritesController < ActionController::API
  def create
    user = User.find_by(api_key: favorite_params[:api_key])

    if user
      forecast = Forecast.find_or_create_by_location(favorite_params[:location])
      new_favorite = user.favorites.create(location: params[:location], forecast_id: forecast.id)

      render json: {
        location: params[:location],
        api_key: user.api_key
      }, status: 201

    else
      render json: { error: 'Unauthorized' }, status: 401
    end
  end

  def index
    user = User.find_by(api_key: api_key_param[:api_key])

    if user
      render json: FavoritesSerializer.new(user).to_json, status: 200
    else
      render json: { error: 'Unauthorized' }, status: 401
    end
  end

  def destroy
    user = User.find_by(api_key: favorite_params[:api_key])
    favorite = user.favorites.find_by(location: favorite_params[:location]) if user

    if user && favorite
      favorite.destroy
      render json: FavoritesSerializer.new(user).to_json, status: 200
    else
      render json: { error: 'Unauthorized' }, status: 401
    end
  end

  private
    def favorite_params
      params.permit(:location, :api_key)
    end

    def api_key_param
      params.permit(:api_key)
    end
end
