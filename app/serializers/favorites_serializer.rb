class FavoritesSerializer
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def to_json
    user.favorites.map do |favorite|
      {
        location: favorite.location,
        current_weather: favorite.forecast.details,
      }
    end
  end
end
