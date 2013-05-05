class HomeController < ApplicationController
  def tweets
    query = params[:query] rescue " "
    @tweets = TweetCache.new.search(query, :geocode => "30.6278,-96.3342,2mi", :count => 10, :result_type => "recent")
    render json: @tweets
  end
end
