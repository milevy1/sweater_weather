class DarkSkyService
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def conn
    @_conn ||= Faraday.new("https://api.darksky.net/forecast/#{ENV['darksky_api_key']}/") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def response
    @_response ||= conn.get("#{latitude},#{longitude}")
  end

  def details
    JSON.parse(response.body)
  end
end
