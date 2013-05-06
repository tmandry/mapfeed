class HomeController < ApplicationController
  def tweets
    query = params[:query]
    @radius = (params[:radius] or "2mi")
    @tweets = TweetCache.new.search(query, :geocode => "30.6278,-96.3342,#{@radius}", :count => 10, :result_type => "recent")
    render json: @tweets
  end
end
