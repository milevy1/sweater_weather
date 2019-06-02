class BackgroundSerializer
  attr_reader :location, :image_url

  def initialize(location, image_url)
    @location = location
    @image_url = image_url
  end

  def json
    {
      'data' => {
        'location' => location,
        'image_url' => image_url
      }
    }
  end
end
