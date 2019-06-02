class GoogleMapsService
  attr_reader :address

  def initialize(address)
    @address = address
  end

  def conn
    @_conn ||= Faraday.new('https://maps.googleapis.com/maps/api/geocode/json') do |f|
      f.adapter Faraday.default_adapter
      f.params['key'] = ENV['google_maps_api_key']
    end
  end

  def response
    @_response ||= conn.get do |req|
      req.params['address'] = address
    end
  end

  def latitude
    JSON.parse(response.body)['results'][0]['geometry']['location']['lat'].to_s
  end

  def longitude
    JSON.parse(response.body)['results'][0]['geometry']['location']['lng'].to_s
  end

  def city
    address.split(',')[0].capitalize
  end

  def state
    address.split(',')[1].upcase
  end

  def city_state
    address.downcase
  end

  def country
    JSON.parse(response.body)['results'][0]['address_components'].last['long_name']
  end
end
