class Api::V1::BackgroundsController < ApplicationController
  def show
    location = params['location']
    background_url = flickr_service(location).background_url

    render json: BackgroundSerializer.new(location, background_url).json
  end

  private
    def flickr_service(location)
      @_flickr_service ||= FlickrService.new(location)
    end
end
