class AmypodeService
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def conn
    @_conn ||= Faraday.new('http://amypode.herokuapp.com/api/v1/antipodes') do |f|
      f.adapter Faraday.default_adapter
      f.headers['api_key'] = ENV['antipode_api_key']
    end
  end

  def response
    @_response ||= conn.get do |req|
      req.params['lat'] = latitude
      req.params['long'] = longitude
    end
  end

  def antipode_coordinates
    JSON.parse(response.body)['data']['attributes']
  end

  def antipode_lat
    antipode_coordinates['lat'].to_s
  end

  def antipode_long
    antipode_coordinates['long'].to_s
  end
end
