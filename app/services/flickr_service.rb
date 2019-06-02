class FlickrService
  attr_reader :location, :filters

  def initialize(location, filters = 'downtown,view')
    @location = location
    @filters = filters
  end

  def conn
    @_conn ||= Faraday.new('https://www.flickr.com/services/feeds/photos_public.gne') do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def response
    @_response ||= conn.get do |req|
      req.params['format'] = 'json'
      req.params['nojsoncallback'] = '1'
      req.params['tags'] = "#{location},#{filters}"
    end
  end

  def background_url
    JSON.parse(response.body)['items'][0]['media']['m']
  end
end
