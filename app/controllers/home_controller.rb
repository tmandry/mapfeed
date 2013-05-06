class HomeController < ApplicationController
  def index
    if user_signed_in? and current_user.last_search
      @query = current_user.last_search.query
      @location = current_user.last_search.location
      @radius = current_user.last_search.radius
    else
      @query = ""
      @location = "College Station, TX"
      @radius = "2mi"
    end
  end

  def tweets
    query = params[:query]
    radius = (params[:radius] or "2mi")
    location = (params[:location] or "College Station, TX")
    geocode = Geocoder.coordinates(location)
    tweets = TweetCache.new.search(query, :geocode => "#{geocode[0]},#{geocode[1]},#{radius}", :count => 100, :result_type => "recent")
    results = {
      tweets: tweets,
      center: geocode
    }

    # Save search terms if user logged in
    if user_signed_in?
      current_user.last_search = SearchTerms.new(
        location: location,
        query: query,
        radius: radius
      )
      current_user.save
    end

    render json: results
  end
end
