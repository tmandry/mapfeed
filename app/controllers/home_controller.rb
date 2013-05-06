class HomeController < ApplicationController
  def tweets
    query = params[:query]
    @radius = (params[:radius] or "2mi")
    location = (params[:location] or "College Station, TX")
    geocode = Geocoder.coordinates(location)
    @tweets = TweetCache.new.search(query, :geocode => "#{geocode[0]},#{geocode[1]},#{@radius}", :count => 100, :result_type => "recent")
    results = {
      tweets: @tweets,
      center: geocode
    }
    render json: results
  end
end
